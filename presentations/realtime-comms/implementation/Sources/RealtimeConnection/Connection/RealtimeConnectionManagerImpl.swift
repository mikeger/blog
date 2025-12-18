//
//  Copyright © 2025 Delivery Hero SE. All rights reserved.
//

import Combine
import CommonDomain
import DeliveryCommon
import Foundation
import Networking
import RiderHomeServiceInterface
import StatusInterface

public extension Realtime {
    final class ConnectionManagerImpl: ConnectionManager {
        private let logger = RealtimeConnectionDebugLogger(category: "ConnectionManagerImpl")

        private let configuration: ConnectionConfiguration
        private let client: Client
        private let stateProvider: ConnectionStateProvider
        private let authTokenProvider: AuthTokenProvider
        private let riderHomeDataService: RiderHomeDataService
        private let stateValidityManager: StateValidityManager
        private let appStateObserver: AppStateObserver
        private let reachability: ReachabilityProvider
        private let delayProvider: AsyncDelayType

        private var clientStateTask: Task<Void, Never>?
        private var tokenUpdatesTask: Task<Void, Never>?
        private var appStateTask: Task<Void, Never>?
        private var messageTask: Task<Void, Never>?
        private var reconnectTask: Task<Void, Never>?
        private var reconnectDelay: TimeInterval
        private var reconnectAttempt: Int = 0
        private let maxReconnectAttempts: Int

        private var isRunning = false
        private var currentToken: Token?

        public init(
            configuration: ConnectionConfiguration,
            client: Client,
            authTokenProvider: AuthTokenProvider,
            riderHomeDataService: RiderHomeDataService,
            stateValidityManager: StateValidityManager,
            appStateObserver: AppStateObserver,
            stateProvider: ConnectionStateProvider,
            reachability: ReachabilityProvider = Reachability(),
            delayProvider: AsyncDelayType = AsyncDelayProvider()
        ) {
            self.configuration = configuration
            self.client = client
            self.stateProvider = stateProvider
            self.authTokenProvider = authTokenProvider
            self.riderHomeDataService = riderHomeDataService
            self.stateValidityManager = stateValidityManager
            self.appStateObserver = appStateObserver
            self.reachability = reachability
            self.delayProvider = delayProvider

            self.reconnectDelay = configuration.reconnectConfiguration.initialBackoffDelay
            self.maxReconnectAttempts = configuration.reconnectConfiguration.maxReconnectAttempts
            start()
        }

        deinit {
            stop()
        }

        public func stop() {
            guard isRunning else { return }

            logger.info("Stopping realtime connection manager")
            isRunning = false

            clientStateTask?.cancel()
            clientStateTask = nil

            tokenUpdatesTask?.cancel()
            tokenUpdatesTask = nil

            currentToken = nil
            reconnectTask?.cancel()
            reconnectTask = nil
            reconnectDelay = configuration.reconnectConfiguration.initialBackoffDelay
            reconnectAttempt = 0

            client.disconnect()
            stateProvider.publishState(.idle)
        }

        public func state() async -> AsyncMulticastStream<ConnectionState> {
            await stateProvider.stateStream()
        }

        public func debugConfigurationSnapshot() -> Realtime.DebugConfigurationSnapshot? {
            Realtime.DebugConfigurationSnapshot(configuration: configuration)
        }
    }
}

private extension Realtime.ConnectionManagerImpl {
    private func start() {
        guard configuration.realtimeConnectionEnabled else {
            logger.info("Realtime connection disabled via configuration")
            stateProvider.publishState(.idle)
            return
        }

        guard !isRunning else {
            logger.debug("Connection manager already running")
            return
        }

        logger.info("Starting realtime connection manager")
        isRunning = true

        startObservingClientState()
        startMonitoringTokenUpdates()
        startObservingAppState()

        if let initialToken = authTokenProvider.token,
           !initialToken.accessToken.isEmpty,
           initialToken.userInfo?.userId != nil {
            logger.debug("Initial auth token available, attempting connection")
            currentToken = initialToken.accessToken
            connect(using: initialToken.accessToken)
        } else {
            logger.debug("Initial auth token not available; waiting for updates")
            stateProvider.publishState(.idle)
        }
        startObservingMessages()
    }

    func startObservingClientState() {
        clientStateTask?.cancel()

        clientStateTask = Task { [weak self] in
            guard let stream = self?.client.state else { return }

            for await clientState in stream {
                self?.handleClientState(clientState)
            }
        }
    }

    func startMonitoringTokenUpdates() {
        tokenUpdatesTask?.cancel()

        tokenUpdatesTask = Task { [weak self] in
            guard let stream = self?.authTokenProvider.tokenUpdates.values else { return }
            for await update in stream {
                self?.handleTokenUpdate(update)
            }
        }
    }

    func startObservingAppState() {
        appStateTask?.cancel()

        appStateTask = Task { [weak self] in
            guard let appStateStream = self?.appStateObserver.stream else { return }
            for await appState in appStateStream {
                await self?.handleAppStateUpdate(appState)
            }
        }
    }

    func startObservingMessages() {
        messageTask?.cancel()

        messageTask = Task { [weak self] in
            guard let messageStream = self?.client.message else { return }
            for await message in messageStream {
                self?.handleMessage(message)
            }
        }
    }

    func handleMessage(_ message: Realtime.Message) {
        logger.debug("Received message: \(message)")
        reconnectDelay = configuration.reconnectConfiguration.initialBackoffDelay
        reconnectAttempt = 0
        if message.shouldUpdateRiderState {
            Task { [weak self] in
                let trigger = RiderHomeAPITrigger(
                    value: LoadStateReason.socketEvent.trigger.rawValue,
                    isScheduled: true
                )
                await self?.riderHomeDataService.refresh(
                    trigger: trigger
                )
            }
        }
    }

    func handleClientState(_ clientState: Realtime.ClientState) {
        switch clientState {
        case .idle:
            stateProvider.publishState(.idle)

        case .connecting:
            stateProvider.publishState(.connecting)

        case .connected:
            stateProvider.publishState(.connected)
            reconnectTask?.cancel()
            reconnectTask = nil

        case .disconnected:
            stateProvider.publishState(.disconnected)
            scheduleReconnect()
        }
    }

    func handleTokenUpdate(_ update: AuthTokenUpdate) {
        switch update {
        case let .updated(token):
            handleTokenProvided(token)
        case .invalidated:
            handleTokenInvalidation()
        }
    }

    func handleAppStateUpdate(_ newState: AppState) async {
        let readyToReconnect = await stateProvider.state().readyToReconnect

        switch (newState, readyToReconnect) {
        case (.foreground, true):
            logger.info("Attemting reconnect")
            reconnectDelay = configuration.reconnectConfiguration.foregroundReconnectDelay
            reconnectAttempt = 0
            currentToken.flatMap(connect(using:))
        default:
            break
        }
    }

    func handleTokenProvided(_ authTokenData: AuthenticationTokenData) {
        guard isRunning else { return }
        let tokenChanged = currentToken != authTokenData.accessToken

        guard tokenChanged else {
            return
        }
        currentToken = authTokenData.accessToken

        client.updateAuth(with: authTokenData.accessToken)

        Task {
            let latestState = await stateProvider.state()
            let connectionIsActive = latestState == .connected || latestState == .connecting

            if connectionIsActive && !configuration.reconnectOnTokenExpiration {
                logger.info("Token refreshed but reconnect disabled by configuration; keeping current connection")
                return
            }

            logger.info("Auth token available, ensuring socket connection")

            connect(using: authTokenData.accessToken)
        }
    }

    func handleTokenInvalidation() {
        logger.warning("Auth token invalidated; disconnecting client")
        currentToken = nil

        guard isRunning else { return }

        client.disconnect()
        stateProvider.publishState(.disconnected)
        stateValidityManager.invalidateState(reason: .other)
    }

    func connect(using token: Realtime.Token) {
        guard isRunning else {
            logger.info("Cancel connect: Connection manager is not running")
            return
        }

        logger.info("Connecting")

        currentToken = token
        client.updateAuth(with: token)
        stateProvider.publishState(.connecting)
        client.connect()
    }

    func scheduleReconnect() {
        reconnectTask?.cancel()
        guard isRunning else { return }
        guard reconnectAttempt < maxReconnectAttempts else {
            logger.info("Stop reconnection, exhausted maximum retry count")
            return
        }
        reconnectTask = Task { [weak self] in
            guard let self else { return }
            while self.isRunning {
                guard let token = self.currentToken else { return }
                if !self.reachability.reachable {
                    logger.debug("Skipping reconnect attempt: offline")
                    await self.delayProvider.sleep(seconds: configuration.reconnectConfiguration.offlinePollInterval)
                    guard !Task.isCancelled else { return }
                    continue
                }

                await self.delayProvider.sleep(seconds: self.reconnectDelay)
                guard !Task.isCancelled else { return }
                logger
                    .info(
                        "Attempting reconnect after \(self.reconnectDelay)s backoff (attempt \(self.reconnectAttempt))"
                    )
                self.connect(using: token)
                self.reconnectDelay = min(
                    self.reconnectDelay * configuration.reconnectConfiguration.backoffMultiplier,
                    configuration.reconnectConfiguration.maxBackoffDelay
                )
                self.reconnectAttempt += 1
                return
            }
        }
    }
}
