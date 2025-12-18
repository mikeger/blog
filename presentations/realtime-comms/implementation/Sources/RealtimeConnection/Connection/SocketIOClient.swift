//
//  Copyright © 2025 Delivery Hero SE. All rights reserved.
//

import CommonDomain
import Foundation
import Networking
import SocketIO

public extension Realtime {
    /// Adapter around the legacy Socket.IO client that exposes a Swift concurrency friendly API.
    final class SocketIOClient: Client {
        private let logger = RealtimeConnectionDebugLogger(category: "SocketIOClient")
        private let serialQueue = DispatchQueue(label: "com.dh.RiderApp.realtime-connection")

        private let socketURL: URL
        private let headerProvider: RequestHeadersProvider
        private let socketManagerFactory: SocketManagerBuilding

        private var socketManager: SocketManagerType?
        private var socket: SocketClientType?
        private var currentState: ClientState = .idle
        private var currentToken: Token?

        private let stateStream: AsyncMulticastStream<ClientState>
        private let stateContinuation: AsyncMulticastStream<ClientState>.Continuation

        public var state: AsyncMulticastStream<ClientState> { stateStream }

        private let messageStream: AsyncMulticastStream<Realtime.Message>
        private let messageContinuation: AsyncMulticastStream<Realtime.Message>.Continuation

        public var message: AsyncMulticastStream<Realtime.Message> { messageStream }

        public convenience init(
            socketURL: URL,
            headerProvider: RequestHeadersProvider
        ) {
            self.init(
                socketURL: socketURL,
                headerProvider: headerProvider,
                socketBuilder: DefaultSocketManagerBuilder()
            )
        }

        init(
            socketURL: URL,
            headerProvider: RequestHeadersProvider,
            socketBuilder: SocketManagerBuilding
        ) {
            self.socketURL = socketURL
            self.headerProvider = headerProvider
            self.socketManagerFactory = socketBuilder
            (self.stateStream, self.stateContinuation) = AsyncMulticastStream<ClientState>.makeStream()
            stateContinuation.yield(.idle)

            (self.messageStream, self.messageContinuation) = AsyncMulticastStream<Realtime.Message>.makeStream()
        }

        deinit {
            stateContinuation.finish()
            messageContinuation.finish()
        }

        public func updateAuth(with token: Token) {
            serialQueue.async { [weak self] in
                guard let self else { return }

                guard !token.isEmpty else {
                    self.logger.warning("Ignoring empty auth token update")
                    self.currentToken = nil
                    return
                }

                if self.currentToken == token {
                    self.logger.debug("Auth token unchanged; skipping update")
                    return
                }

                self.logger.info("Auth token updated")
                self.currentToken = token

                if self.socket != nil {
                    self.logger.debug("Rebuilding socket to apply updated auth token")
                    self.rebuildSocket(with: token)
                }
            }
        }

        public func connect() {
            serialQueue.async { [weak self] in
                guard let self else { return }
                guard let token = self.currentToken else {
                    self.logger.error("Cannot connect: missing auth token")
                    self.transition(to: .disconnected)
                    return
                }

                if self.socket == nil {
                    self.logger.debug("Preparing socket before connecting")
                    self.prepareSocket(with: token)
                }

                self.logger.info("Connecting to Socket.IO server at \(self.socketURL.absoluteString)")
                self.transition(to: .connecting)
                self.socket?.connect()
            }
        }

        public func disconnect() {
            serialQueue.async { [weak self] in
                guard let self else { return }
                guard self.socket != nil else {
                    self.logger.debug("Disconnect requested without an active socket")
                    self.transition(to: .disconnected)
                    return
                }

                self.logger.info("Disconnecting from Socket.IO server")
                self.teardownSocket()
                self.transition(to: .disconnected)
            }
        }
    }

    enum SocketIOClientError: Error {
        case decodingError(message: String)
    }
}

private extension Realtime.SocketIOClient {
    private func prepareSocket(with token: Realtime.Token) {
        let manager = socketManagerFactory.makeManager(
            socketURL: socketURL,
            config: options(with: token)
        )
        manager.handleQueue = serialQueue

        let socket = manager.makeSocket(forNamespace: "/rider-app")
        registerHandlers(for: socket)

        socketManager = manager
        self.socket = socket
    }

    private func rebuildSocket(with token: Realtime.Token) {
        teardownSocket()
        prepareSocket(with: token)
    }

    private func teardownSocket() {
        socket?.removeAllHandlers()
        socket?.disconnect()
        socket = nil
        socketManager = nil
    }

    private func options(with token: Realtime.Token) -> SocketIOClientConfiguration {
        var additionalHeaders = headerProvider.getAdditionalHeaders()

        var config: SocketIOClientConfiguration = [
            .forceNew(true),
            .compress,
            .forceWebsockets(true),
            .reconnects(false),
            .version(.three) // version three of the client library corresponding to version 4 of the protocol (EIO=4)
        ]

        if shouldEnforceSecureTransport {
            config.insert(.secure(true))
        }

#if DEBUG
        config.insert(.log(true))
#endif
        additionalHeaders["Authorization"] = "Bearer \(token)"
        config.insert(SocketIOClientOption.extraHeaders(additionalHeaders))
        return config
    }

    private var shouldEnforceSecureTransport: Bool {
        guard let host = socketURL.host?.lowercased() else { return true }
        return host != "localhost"
    }

    private func registerHandlers(for socket: SocketClientType) {
        socket.on(clientEvent: .connect) { [weak self] _ in
            self?.serialQueue.async {
                guard let self else { return }
                self.logger.info("Socket connected")
                self.transition(to: .connected)
            }
        }

        socket.on(clientEvent: .disconnect) { [weak self] data in
            self?.serialQueue.async {
                guard let self else { return }
                let reason = data.first as? String ?? "unknown"
                self.logger.debug("Socket disconnected, reason: \(reason)")
                self.transition(to: .disconnected)
            }
        }

        socket.on(clientEvent: .reconnect) { [weak self] _ in
            self?.serialQueue.async {
                guard let self else { return }
                self.logger.info("Socket reconnecting")
                self.transition(to: .connecting)
            }
        }

        socket.on(clientEvent: .error) { [weak self] data in
            self?.serialQueue.async {
                guard let self else { return }
                let message = Self.describeErrorPayload(data)
                self.logger.error("Socket encountered error: \(message)")
                self.transition(to: .disconnected)
            }
        }

        socket.on("server:delivery_updated") { [weak self] data in
            guard let self else { return }

            for case let payload as [String: Any] in data {
                do {
                    let message = try Realtime.OpaqueMessage(dictionary: payload)
                    self.messageContinuation.yield(message)
                } catch {
                    self.logger.error("Message decoding error: \(error)")
                }
            }
        }
    }

    private func transition(to newState: Realtime.ClientState) {
        guard currentState != newState else { return }
        currentState = newState
        stateContinuation.yield(newState)
    }

    static func describeErrorPayload(_ data: [Any]) -> String {
        guard let first = data.first else { return "unknown" }

        if let string = first as? String {
            return string
        }

        if let dict = first as? [String: Any],
           let message = dict["message"] as? String {
            return message
        }

        return "unknown"
    }
}

// sourcery: AutoMockable
protocol SocketManagerBuilding {
    func makeManager(socketURL: URL, config: SocketIOClientConfiguration) -> SocketManagerType
}

struct DefaultSocketManagerBuilder: SocketManagerBuilding {
    func makeManager(socketURL: URL, config: SocketIOClientConfiguration) -> SocketManagerType {
        SocketManager(socketURL: socketURL, config: config)
    }
}
// sourcery: AutoMockable
protocol SocketManagerType: AnyObject {
    var handleQueue: DispatchQueue { get set }
    func makeSocket(forNamespace: String) -> SocketClientType
    func disconnect()
}

// sourcery: AutoMockable
protocol SocketClientType: AnyObject {
    func on(clientEvent: SocketClientEvent, callback: @escaping ([Any]) -> Void)
    func on(_ event: String, callback: @escaping ([Any]) -> Void)
    func connect()
    func disconnect()
    func removeAllHandlers()
}

extension SocketManager: SocketManagerType {
    func makeSocket(forNamespace namespace: String) -> SocketClientType {
        socket(forNamespace: namespace)
    }
}

extension SocketIO.SocketIOClient: SocketClientType {
    func on(clientEvent event: SocketClientEvent, callback: @escaping ([Any]) -> Void) {
        on(clientEvent: event) { data, _ in
            callback(data)
        }
    }

    func on(_ event: String, callback: @escaping ([Any]) -> Void) {
        on(event) { data, _ in
            callback(data)
        }
    }

    func connect() {
        connect(withPayload: nil)
    }
}
