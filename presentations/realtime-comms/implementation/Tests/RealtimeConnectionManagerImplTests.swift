//
//  Copyright © 2025 Delivery Hero SE. All rights reserved.
//

import Combine
import CommonDomain
import CommonDomainTesting
import DeliveryCommon
import Foundation
import Networking
@testable import RealtimeConnection
import StatusInterface
import Testing

@Suite
struct RealtimeConnectionManagerImplTests {
    @Test
    func testRealtimeConnectionDeallocates() async {
        await assertObjectDeallocates {
            await makeContext().sut
        }
    }

    @Test
    func testDoesNotStartWhenRealtimeDisabled() async {
        let context = await makeContext { mocks in
            mocks.configuration.realtimeConnectionEnabled = false
        }

        #expect(context.mocks.client.connectCallsCount == 0)

        let stateStream = await context.sut.state()
        var iterator = stateStream.makeAsyncIterator()
        let firstState = await iterator.next()

        #expect(firstState == .idle)
    }

    @Test
    func testInitialTokenTriggersImmediateConnection() async {
        let token = makeToken(accessToken: "initial-token")
        let context = await makeContext { mocks in
            mocks.authTokenProvider.token = token
        }

        #expect(context.mocks.client.connectCallsCount == 1)
        #expect(context.mocks.client.updateAuthWithReceivedInvocations == [token.accessToken])

        let stateStream = await context.sut.state()
        var iterator = stateStream.makeAsyncIterator()
        let latestState = await iterator.next()

        #expect(latestState == .connecting)
    }

    @Test
    func testTokenUpdateConnectsWhenIdle() async {
        let context = await makeContext()
        let token = makeToken(accessToken: "refreshed-token")

        await context.waitForConnection(token: token) {
            context.mocks.tokenUpdatesSubject.send(.updated(token))
        }

        #expect(context.mocks.client.connectCallsCount == 1)
        #expect(context.mocks.client.updateAuthWithReceivedInvocations.filter { $0 == token.accessToken }.count == 2)
    }

    @Test
    func testSameTokenWhileConnectedDoesNotReconnect() async {
        let token = makeToken(accessToken: "stable-token")
        let context = await makeContext { mocks in
            mocks.authTokenProvider.token = token
        }

        #expect(context.mocks.client.connectCallsCount == 1)

        await context.waitForState(.connected) {
            context.mocks.clientStateContinuation.yield(.connected)
        }

        context.mocks.tokenUpdatesSubject.send(.updated(token))

        #expect(context.mocks.client.connectCallsCount == 1)
        #expect(context.mocks.client.updateAuthWithCallsCount == 1)
    }

    @Test
    func testTokenInvalidationDisconnectsAndInvalidatesState() async {
        let context = await makeContext()

        let state = await context.waitForState(.disconnected) {
            context.mocks.tokenUpdatesSubject.send(.invalidated)
        }

        #expect(context.mocks.client.disconnectCallsCount == 1)
        #expect(context.mocks.stateValidityManager.invalidateStateReasonReceivedReason == .other)
        #expect(state == .disconnected)
    }

    @Test
    func testMessageRefreshesRiderHomeServiceWhenEnabled() async {
        let context = await makeContext()

        await context.waitForEventProcessing {
            context.mocks.messageContinuation.yield(DummyMessage())
        }

        #expect(context.mocks.riderHomeDataService.refreshTriggerRequestContextCallsCount == 1)

        let args = context.mocks.riderHomeDataService.refreshTriggerRequestContextReceivedArguments
        #expect(args?.requestContext == nil)
        #expect(args?.trigger.value == LoadStateReason.socketEvent.trigger.rawValue)
        #expect(args?.trigger.isScheduled == true)
    }

    @Test
    func testReconnectsAfterDisconnectWhenReachable() async throws {
        let token = makeToken(accessToken: "auto-reconnect")
        let context = await makeContext { mocks in
            mocks.authTokenProvider.token = token
        }

        #expect(context.mocks.client.connectCallsCount == 1)

        context.mocks.clientStateContinuation.yield(.disconnected)

        try await context.mocks.delayProvider.waitForRecordedDelays(count: 1)
        #expect(await context.mocks.delayProvider.recordedDelays() == [1])
        await context.mocks.delayProvider.resumeNextDelay()
        let connected = await context.waitUntil { context.mocks.client.connectCallsCount == 2 }
        #expect(connected)
    }

    @Test
    func testReconnectWaitsForReachabilityWhenOffline() async throws {
        let token = makeToken(accessToken: "offline-reconnect")
        let context = await makeContext { mocks in
            mocks.authTokenProvider.token = token
            mocks.reachability.reachable = false
        }

        context.mocks.clientStateContinuation.yield(.disconnected)

        try await context.mocks.delayProvider.waitForRecordedDelays(count: 1)
        #expect(await context.mocks.delayProvider.recordedDelays() == [2])
        #expect(context.mocks.client.connectCallsCount == 1)

        context.mocks.reachability.reachable = true

        await context.mocks.delayProvider.resumeNextDelay()
        try await context.mocks.delayProvider.waitForRecordedDelays(count: 2)
        #expect(await context.mocks.delayProvider.recordedDelays() == [2, 1])
        await context.mocks.delayProvider.resumeNextDelay()
        let connected = await context.waitUntil { context.mocks.client.connectCallsCount == 2 }
        #expect(connected)
    }
}

private extension RealtimeConnectionManagerImplTests {
    struct TestContext {
        let sut: Realtime.ConnectionManagerImpl
        var mocks: TestMocks

        func waitForConnection(token _: AuthenticationTokenData, _ trigger: () -> Void) async {
            await withUnsafeContinuation { continuation in
                mocks.client.connectClosure = {
                    continuation.resume()
                }
                trigger()
            }
        }

        func waitForEventProcessing(_ trigger: () -> Void) async {
            await withUnsafeContinuation { continuation in
                mocks.riderHomeDataService
                    .refreshTriggerRequestContextClosure = { [service = mocks.riderHomeDataService] _, _ in
                        service.refreshTriggerRequestContextClosure = nil
                        continuation.resume()
                    }
                trigger()
            }
        }

        @discardableResult
        func waitForState(
            _ expectedState: Realtime.ConnectionState,
            trigger: () -> Void
        ) async -> Realtime.ConnectionState {
            let stateStream = await sut.state()
            var iterator = stateStream.makeAsyncIterator()

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

        func waitForNotification(
            _ name: Notification.Name,
            object: AnyObject? = nil,
            trigger: () -> Void
        ) async -> Notification {
            let sequence = NotificationCenter.default.notifications(named: name, object: object)

            trigger()

            for await notification in sequence {
                return notification
            }

            fatalError("Notification sequence finished without emitting \(name)")
        }

        func waitUntil(
            timeout: TimeInterval = 1,
            _ predicate: @escaping () -> Bool
        ) async -> Bool {
            let endDate = Date().addingTimeInterval(timeout)
            while !predicate(), Date() < endDate {
                try? await Task.sleep(nanoseconds: 10_000_000)
            }
            return predicate()
        }
    }

    struct TestMocks {
        var configuration: RealtimeConnectionConfigurationMock
        var client: RealtimeClientMock
        var authTokenProvider: AuthTokenProviderMock
        var riderHomeDataService: RiderHomeDataServiceMock
        var stateValidityManager: StateValidityManagerMock
        var appStateObserver: AppStateObserverMock
        var reachability: ReachabilityStub
        let delayProvider: AsyncDelayProviderStub
        let tokenUpdatesSubject: PassthroughSubject<AuthTokenUpdate, Never>
        let clientStateContinuation: AsyncMulticastStream<Realtime.ClientState>.Continuation
        let messageContinuation: AsyncMulticastStream<Realtime.Message>.Continuation
        let appStateContinuation: AsyncMulticastStream<AppState>.Continuation
    
        // swiftlint:disable force_unwrapping
        init() {
            self.configuration = RealtimeConnectionConfigurationMock()
            configuration.realtimeConnectionEnabled = true
            configuration.reconnectOnTokenExpiration = true
            configuration.gatewayURL = URL(string: "ws://localhost:3000/")!
            configuration.reconnectConfiguration = Realtime.ReconnectConfigurationStruct()

            self.client = RealtimeClientMock()
            let (clientStateStream, clientStateContinuation) = AsyncMulticastStream<Realtime.ClientState>.makeStream()
            client.state = clientStateStream
            self.clientStateContinuation = clientStateContinuation

            let (messageStream, messageContinuation) = AsyncMulticastStream<Realtime.Message>.makeStream()
            client.message = messageStream
            self.messageContinuation = messageContinuation

            self.authTokenProvider = AuthTokenProviderMock()
            self.tokenUpdatesSubject = PassthroughSubject<AuthTokenUpdate, Never>()
            authTokenProvider.tokenUpdates = tokenUpdatesSubject.eraseToAnyPublisher()
            authTokenProvider.token = nil

            self.riderHomeDataService = RiderHomeDataServiceMock()
            riderHomeDataService.isEnabled = true

            self.stateValidityManager = StateValidityManagerMock()

            self.appStateObserver = AppStateObserverMock()
            let (appStateStream, appStateContinuation) = AsyncMulticastStream<AppState>.makeStream()
            appStateObserver.stream = appStateStream
            appStateObserver.underlyingAppState = .foreground
            self.appStateContinuation = appStateContinuation

            self.reachability = ReachabilityStub()
            self.delayProvider = AsyncDelayProviderStub()
        }
        // swiftlint:enable force_unwrapping
    }

    func makeContext(
        configure: (inout TestMocks) -> Void = { _ in }
    ) async -> TestContext {
        var mocks = TestMocks()
        configure(&mocks)

        let sut = Realtime.ConnectionManagerImpl(
            configuration: mocks.configuration,
            client: mocks.client,
            authTokenProvider: mocks.authTokenProvider,
            riderHomeDataService: mocks.riderHomeDataService,
            stateValidityManager: mocks.stateValidityManager,
            appStateObserver: mocks.appStateObserver,
            stateProvider: Realtime.ConnectionStateProviderImpl(),
            reachability: mocks.reachability,
            delayProvider: mocks.delayProvider
        )

        // Wait for subscriptions to register
        try? await Task.sleep(nanoseconds: 100000)

        return TestContext(sut: sut, mocks: mocks)
    }

    final class ReachabilityStub: ReachabilityProvider {
        var reachable: Bool = true
    }

    actor AsyncDelayProviderStub: AsyncDelayType {
        enum Error: Swift.Error {
            case timeout
        }

        private var delays: [TimeInterval] = []
        private var continuations: [CheckedContinuation<Void, Never>] = []

        func sleep(seconds: TimeInterval) async {
            delays.append(seconds)
            await withCheckedContinuation { continuation in
                continuations.append(continuation)
            }
        }

        func waitForRecordedDelays(count: Int, timeout: TimeInterval = 1) async throws {
            let endDate = Date().addingTimeInterval(timeout)
            while delays.count < count {
                if Date() > endDate {
                    throw Error.timeout
                }
                try? await Task.sleep(nanoseconds: 10_000_000)
            }
        }

        func recordedDelays() -> [TimeInterval] {
            delays
        }

        func resumeNextDelay() {
            guard !continuations.isEmpty else { return }
            continuations.removeFirst().resume()
        }
    }

    func makeToken(accessToken: String) -> AuthenticationTokenData {
        AuthenticationTokenData(
            accessToken: accessToken,
            refreshToken: "refresh-\(accessToken)",
            deviceToken: "device-token",
            expiresIn: 1800,
            countryCode: "DE",
            userInfo: AuthenticationUserInfoData(
                userId: UUID().uuidString,
                email: nil,
                name: nil,
                role: nil,
                roles: nil,
                countries: nil
            )
        )
    }

    struct DummyMessage: Realtime.Message {
        let metadata: Realtime.Metadata
        let topic: String?

        init(topic: String? = nil) {
            self.topic = topic
            self.metadata = Realtime.Metadata(
                messageId: UUID().uuidString,
                eventType: "test",
                timestamp: Date(),
                source: "unit-test",
                version: "1"
            )
        }
    }
}
