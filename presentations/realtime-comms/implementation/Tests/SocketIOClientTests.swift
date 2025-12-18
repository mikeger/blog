//
//  Copyright © 2025 Delivery Hero SE. All rights reserved.
//

import Foundation
import Networking
@testable import RealtimeConnection
import SocketIO
import Testing

@Suite
struct SocketIOClientTests {
    @Test
    func testConnectWithoutTokenPublishesDisconnectedState() async {
        let context = makeContext(socketManagers: [])

        let state = await context.waitForState(.disconnected) {
            context.sut.connect()
        }

        #expect(state == .disconnected)
        #expect(context.mocks.managerFactory.makeManagerSocketURLConfigCallsCount == 0)
    }

    @Test
    func testSocketEventsDriveStateTransitions() async {
        let socket = SocketClientTypeMock()
        let manager = SocketManagerTypeMock()
        manager.makeSocketForNamespaceReturnValue = socket
        let context = makeContext(socketManagers: [manager])

        context.sut.updateAuth(with: "token")

        await context.waitForState(.connecting) {
            context.sut.connect()
        }

        await context.waitForState(.connected) {
            socket.emit(clientEvent: .connect)
        }

        await context.waitForState(.disconnected) {
            socket.emit(clientEvent: .disconnect, data: ["bye"])
        }

        await context.waitForState(.connecting) {
            socket.emit(clientEvent: .reconnect)
        }

        await context.waitForState(.disconnected) {
            socket.emit(clientEvent: .error, data: ["boom"])
        }
    }

    @Test
    func testServerMessageEmitsOpaqueMessage() async {
        let socket = SocketClientTypeMock()
        let manager = SocketManagerTypeMock()
        manager.makeSocketForNamespaceReturnValue = socket
        let context = makeContext(socketManagers: [manager])

        context.sut.updateAuth(with: "token")
        await context.waitForState(.connecting) {
            context.sut.connect()
        }

        let payload: [String: Any] = [
            "body": "{\"test\":true}",
            "metadata": ["eventType": "someType"]
        ]

        let message = await context.waitForMessage {
            socket.emit(event: "server:delivery_updated", data: [payload])
        }

        #expect(message.metadata.eventType == "someType")
    }

    @Test
    func testUpdatingAuthWithNewTokenRebuildsSocket() async {
        let firstSocket = SocketClientTypeMock()
        let secondSocket = SocketClientTypeMock()
        let firstManager = SocketManagerTypeMock()
        firstManager.makeSocketForNamespaceReturnValue = firstSocket
        let secondManager = SocketManagerTypeMock()
        secondManager.makeSocketForNamespaceReturnValue = secondSocket
        let context = makeContext(socketManagers: [firstManager, secondManager])

        context.sut.updateAuth(with: "token-1")
        await context.waitForState(.connecting) {
            context.sut.connect()
        }
        #expect(firstSocket.connectCallsCount == 1)

        context.sut.updateAuth(with: "token-2")

        // Give the serial queue time to rebuild the socket.
        try? await Task.sleep(nanoseconds: 200000)

        #expect(context.mocks.managerFactory.makeManagerSocketURLConfigCallsCount == 2)
        #expect(firstSocket.disconnectCallsCount == 1)
        #expect(firstSocket.removeAllHandlersCallsCount == 1)
        #expect(secondSocket.connectCallsCount == 0)
    }
}

private extension SocketIOClientTests {
    // swiftlint:disable force_unwrapping
    func makeContext(socketManagers: [SocketManagerTypeMock]) -> TestContext {
        var headerProvider = RequestHeadersProviderStub()
        headerProvider.headers = ["X-Test": "1"]

        let factory = SocketManagerBuildingMock()
        factory.makeManagerSocketURLConfigClosure = { _, _ in
            socketManagers[(factory.makeManagerSocketURLConfigCallsCount - 1) % socketManagers.count]
        }
        let sut = Realtime.SocketIOClient(
            socketURL: URL(string: "https://example.com")!,
            headerProvider: headerProvider,
            socketBuilder: factory
        )

        return TestContext(sut: sut, mocks: .init(headerProvider: headerProvider, managerFactory: factory))
    }
    // swiftlint:enable force_unwrapping

    struct TestContext {
        let sut: Realtime.SocketIOClient
        var mocks: TestMocks

        @discardableResult
        func waitForState(
            _ expectedState: Realtime.ClientState,
            trigger: () -> Void
        ) async -> Realtime.ClientState {
            var iterator = sut.state.makeAsyncIterator()

            return await withCheckedContinuation { continuation in
                Task {
                    while let state = await iterator.next() {
                        if state == expectedState {
                            continuation.resume(returning: state)
                            return
                        }
                    }
                }

                trigger()
            }
        }

        func waitForMessage(trigger: () -> Void) async -> Realtime.Message {
            var iterator = sut.message.makeAsyncIterator()

            return await withCheckedContinuation { continuation in
                Task {
                    while let message = await iterator.next() {
                        continuation.resume(returning: message)
                        return
                    }
                }

                trigger()
            }
        }
    }

    struct TestMocks {
        var headerProvider: RequestHeadersProviderStub
        var managerFactory: SocketManagerBuildingMock
    }

    struct RequestHeadersProviderStub: RequestHeadersProvider {
        var headers: [String: String] = [:]

        func getAdditionalHeaders() -> [String: String] {
            headers
        }
    }
}

extension SocketClientTypeMock {
    func emit(clientEvent: SocketClientEvent, data: [Any] = []) {
        for invocation in onClientEventCallbackReceivedInvocations where invocation.clientEvent == clientEvent {
            invocation.callback(data)
        }
    }

    func emit(event: String, data: [Any] = []) {
        for invocation in onCallbackReceivedInvocations where invocation.event == event {
            invocation.callback(data)
        }
    }
}
