// Generated using Sourcery 2.3.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


//swiftlint:disable all

@testable import RealtimeConnection
import Foundation
import UIKit
import Combine
import CommonDomain
import RiderHomeServiceInterface
import Localizations
import Networking
import DeliveryCommon
import DependencyInjection
import SocketIO

public class AuthTokenProviderMock: AuthTokenProvider {
    public init () {}

    //MARK: - token

    public var token: AuthenticationTokenData?


    //MARK: - tokenUpdates

    public var tokenUpdates: AnyPublisher<AuthTokenUpdate, Never> {
        get { return underlyingTokenUpdates }
        set(value) { underlyingTokenUpdates = value }
    }
    public var underlyingTokenUpdates: AnyPublisher<AuthTokenUpdate, Never>!
}

class RealtimeClientMock: Realtime.Client {

    //MARK: - state

    var state: AsyncMulticastStream<Realtime.ClientState> {
        get { return underlyingState }
        set(value) { underlyingState = value }
    }
    var underlyingState: AsyncMulticastStream<Realtime.ClientState>!

    //MARK: - message

    var message: AsyncMulticastStream<Realtime.Message> {
        get { return underlyingMessage }
        set(value) { underlyingMessage = value }
    }
    var underlyingMessage: AsyncMulticastStream<Realtime.Message>!

    //MARK: - connect

    var connectCallsCount = 0
    var connectCalled: Bool {
        return connectCallsCount > 0
    }
    var connectClosure: (() -> Void)?

    func connect() {
        connectCallsCount += 1
        connectClosure?()
    }

    //MARK: - updateAuth

    var updateAuthWithCallsCount = 0
    var updateAuthWithCalled: Bool {
        return updateAuthWithCallsCount > 0
    }
    var updateAuthWithReceivedToken: Realtime.Token?
    var updateAuthWithReceivedInvocations: [Realtime.Token] = []
    var updateAuthWithClosure: ((Realtime.Token) -> Void)?

    func updateAuth(with token: Realtime.Token) {
        updateAuthWithCallsCount += 1
        updateAuthWithReceivedToken = token
        updateAuthWithReceivedInvocations.append(token)
        updateAuthWithClosure?(token)
    }

    //MARK: - disconnect

    var disconnectCallsCount = 0
    var disconnectCalled: Bool {
        return disconnectCallsCount > 0
    }
    var disconnectClosure: (() -> Void)?

    func disconnect() {
        disconnectCallsCount += 1
        disconnectClosure?()
    }
}

class RealtimeConnectionConfigurationMock: Realtime.ConnectionConfiguration {

    //MARK: - realtimeConnectionEnabled

    var realtimeConnectionEnabled: Bool {
        get { return underlyingRealtimeConnectionEnabled }
        set(value) { underlyingRealtimeConnectionEnabled = value }
    }
    var underlyingRealtimeConnectionEnabled: Bool!

    //MARK: - reconnectOnTokenExpiration

    var reconnectOnTokenExpiration: Bool {
        get { return underlyingReconnectOnTokenExpiration }
        set(value) { underlyingReconnectOnTokenExpiration = value }
    }
    var underlyingReconnectOnTokenExpiration: Bool!

    //MARK: - gatewayURL

    var gatewayURL: URL {
        get { return underlyingGatewayURL }
        set(value) { underlyingGatewayURL = value }
    }
    var underlyingGatewayURL: URL!

    //MARK: - reconnectConfiguration

    var reconnectConfiguration: Realtime.ReconnectConfiguration {
        get { return underlyingReconnectConfiguration }
        set(value) { underlyingReconnectConfiguration = value }
    }
    var underlyingReconnectConfiguration: Realtime.ReconnectConfiguration!
}

public class RiderHomeDataServiceMock: RiderHomeDataService {
    public init () {}

    //MARK: - isEnabled

    public var isEnabled: Bool {
        get { return underlyingIsEnabled }
        set(value) { underlyingIsEnabled = value }
    }
    public var underlyingIsEnabled: Bool!

    //MARK: - stream

    public var stream: AsyncMulticastStream<RiderHomeAPIUpdate> {
        get { return underlyingStream }
        set(value) { underlyingStream = value }
    }
    public var underlyingStream: AsyncMulticastStream<RiderHomeAPIUpdate>!

    //MARK: - refresh

    public var refreshTriggerRequestContextCallsCount = 0
    public var refreshTriggerRequestContextCalled: Bool {
        return refreshTriggerRequestContextCallsCount > 0
    }
    public var refreshTriggerRequestContextReceivedArguments: (trigger: RiderHomeAPITrigger, requestContext: RiderHomeRequestContext?)?
    public var refreshTriggerRequestContextReceivedInvocations: [(trigger: RiderHomeAPITrigger, requestContext: RiderHomeRequestContext?)] = []
    public var refreshTriggerRequestContextClosure: ((RiderHomeAPITrigger, RiderHomeRequestContext?) async -> Void)?

    public func refresh(trigger: RiderHomeAPITrigger, requestContext: RiderHomeRequestContext?) async {
        refreshTriggerRequestContextCallsCount += 1
        refreshTriggerRequestContextReceivedArguments = (trigger: trigger, requestContext: requestContext)
        refreshTriggerRequestContextReceivedInvocations.append((trigger: trigger, requestContext: requestContext))
        await refreshTriggerRequestContextClosure?(trigger, requestContext)
    }
}

public class RiderHomeFeatureFlagProviderMock: RiderHomeFeatureFlagProvider {
    public init () {}

    //MARK: - isRiderHomeAPIEnabled

    public var isRiderHomeAPIEnabled: Bool {
        get { return underlyingIsRiderHomeAPIEnabled }
        set(value) { underlyingIsRiderHomeAPIEnabled = value }
    }
    public var underlyingIsRiderHomeAPIEnabled: Bool!
}

class SocketClientTypeMock: SocketClientType {

    //MARK: - on

    var onClientEventCallbackCallsCount = 0
    var onClientEventCallbackCalled: Bool {
        return onClientEventCallbackCallsCount > 0
    }
    var onClientEventCallbackReceivedArguments: (clientEvent: SocketClientEvent, callback: ([Any]) -> Void)?
    var onClientEventCallbackReceivedInvocations: [(clientEvent: SocketClientEvent, callback: ([Any]) -> Void)] = []
    var onClientEventCallbackClosure: ((SocketClientEvent, @escaping ([Any]) -> Void) -> Void)?

    func on(clientEvent: SocketClientEvent, callback: @escaping ([Any]) -> Void) {
        onClientEventCallbackCallsCount += 1
        onClientEventCallbackReceivedArguments = (clientEvent: clientEvent, callback: callback)
        onClientEventCallbackReceivedInvocations.append((clientEvent: clientEvent, callback: callback))
        onClientEventCallbackClosure?(clientEvent, callback)
    }

    //MARK: - on

    var onCallbackCallsCount = 0
    var onCallbackCalled: Bool {
        return onCallbackCallsCount > 0
    }
    var onCallbackReceivedArguments: (event: String, callback: ([Any]) -> Void)?
    var onCallbackReceivedInvocations: [(event: String, callback: ([Any]) -> Void)] = []
    var onCallbackClosure: ((String, @escaping ([Any]) -> Void) -> Void)?

    func on(_ event: String, callback: @escaping ([Any]) -> Void) {
        onCallbackCallsCount += 1
        onCallbackReceivedArguments = (event: event, callback: callback)
        onCallbackReceivedInvocations.append((event: event, callback: callback))
        onCallbackClosure?(event, callback)
    }

    //MARK: - connect

    var connectCallsCount = 0
    var connectCalled: Bool {
        return connectCallsCount > 0
    }
    var connectClosure: (() -> Void)?

    func connect() {
        connectCallsCount += 1
        connectClosure?()
    }

    //MARK: - disconnect

    var disconnectCallsCount = 0
    var disconnectCalled: Bool {
        return disconnectCallsCount > 0
    }
    var disconnectClosure: (() -> Void)?

    func disconnect() {
        disconnectCallsCount += 1
        disconnectClosure?()
    }

    //MARK: - removeAllHandlers

    var removeAllHandlersCallsCount = 0
    var removeAllHandlersCalled: Bool {
        return removeAllHandlersCallsCount > 0
    }
    var removeAllHandlersClosure: (() -> Void)?

    func removeAllHandlers() {
        removeAllHandlersCallsCount += 1
        removeAllHandlersClosure?()
    }
}

class SocketManagerBuildingMock: SocketManagerBuilding {

    //MARK: - makeManager

    var makeManagerSocketURLConfigCallsCount = 0
    var makeManagerSocketURLConfigCalled: Bool {
        return makeManagerSocketURLConfigCallsCount > 0
    }
    var makeManagerSocketURLConfigReceivedArguments: (socketURL: URL, config: SocketIOClientConfiguration)?
    var makeManagerSocketURLConfigReceivedInvocations: [(socketURL: URL, config: SocketIOClientConfiguration)] = []
    var makeManagerSocketURLConfigReturnValue: SocketManagerType!
    var makeManagerSocketURLConfigClosure: ((URL, SocketIOClientConfiguration) -> SocketManagerType)?

    func makeManager(socketURL: URL, config: SocketIOClientConfiguration) -> SocketManagerType {
        makeManagerSocketURLConfigCallsCount += 1
        makeManagerSocketURLConfigReceivedArguments = (socketURL: socketURL, config: config)
        makeManagerSocketURLConfigReceivedInvocations.append((socketURL: socketURL, config: config))
        if let makeManagerSocketURLConfigClosure = makeManagerSocketURLConfigClosure {
            return makeManagerSocketURLConfigClosure(socketURL, config)
        } else {
            return makeManagerSocketURLConfigReturnValue
        }
    }
}

class SocketManagerTypeMock: SocketManagerType {

    //MARK: - handleQueue

    var handleQueue: DispatchQueue {
        get { return underlyingHandleQueue }
        set(value) { underlyingHandleQueue = value }
    }
    var underlyingHandleQueue: DispatchQueue!

    //MARK: - makeSocket

    var makeSocketForNamespaceCallsCount = 0
    var makeSocketForNamespaceCalled: Bool {
        return makeSocketForNamespaceCallsCount > 0
    }
    var makeSocketForNamespaceReceivedForNamespace: String?
    var makeSocketForNamespaceReceivedInvocations: [String] = []
    var makeSocketForNamespaceReturnValue: SocketClientType!
    var makeSocketForNamespaceClosure: ((String) -> SocketClientType)?

    func makeSocket(forNamespace: String) -> SocketClientType {
        makeSocketForNamespaceCallsCount += 1
        makeSocketForNamespaceReceivedForNamespace = forNamespace
        makeSocketForNamespaceReceivedInvocations.append(forNamespace)
        if let makeSocketForNamespaceClosure = makeSocketForNamespaceClosure {
            return makeSocketForNamespaceClosure(forNamespace)
        } else {
            return makeSocketForNamespaceReturnValue
        }
    }

    //MARK: - disconnect

    var disconnectCallsCount = 0
    var disconnectCalled: Bool {
        return disconnectCallsCount > 0
    }
    var disconnectClosure: (() -> Void)?

    func disconnect() {
        disconnectCallsCount += 1
        disconnectClosure?()
    }
}

public class StateValidityManagerMock: StateValidityManager {
    public init () {}

    //MARK: - invalidateState

    public var invalidateStateReasonCallsCount = 0
    public var invalidateStateReasonCalled: Bool {
        return invalidateStateReasonCallsCount > 0
    }
    public var invalidateStateReasonReceivedReason: LoadStateReason?
    public var invalidateStateReasonReceivedInvocations: [LoadStateReason] = []
    public var invalidateStateReasonClosure: ((LoadStateReason) -> Void)?

    public func invalidateState(reason: LoadStateReason) {
        invalidateStateReasonCallsCount += 1
        invalidateStateReasonReceivedReason = reason
        invalidateStateReasonReceivedInvocations.append(reason)
        invalidateStateReasonClosure?(reason)
    }
}

public class StateValidityObserverMock: StateValidityObserver {
    public init () {}

    //MARK: - onStateInvalidated

    public var onStateInvalidatedReasonCallsCount = 0
    public var onStateInvalidatedReasonCalled: Bool {
        return onStateInvalidatedReasonCallsCount > 0
    }
    public var onStateInvalidatedReasonReceivedReason: LoadStateReason?
    public var onStateInvalidatedReasonReceivedInvocations: [LoadStateReason] = []
    public var onStateInvalidatedReasonClosure: ((LoadStateReason) -> Void)?

    public func onStateInvalidated(reason: LoadStateReason) {
        onStateInvalidatedReasonCallsCount += 1
        onStateInvalidatedReasonReceivedReason = reason
        onStateInvalidatedReasonReceivedInvocations.append(reason)
        onStateInvalidatedReasonClosure?(reason)
    }
}

public class StateValidityPublisherMock: StateValidityPublisher {
    public init () {}

    //MARK: - register

    public var registerObserverCallsCount = 0
    public var registerObserverCalled: Bool {
        return registerObserverCallsCount > 0
    }
    public var registerObserverReceivedObserver: StateValidityObserver?
    public var registerObserverReceivedInvocations: [StateValidityObserver] = []
    public var registerObserverClosure: ((StateValidityObserver) -> Void)?

    public func register(observer: StateValidityObserver) {
        registerObserverCallsCount += 1
        registerObserverReceivedObserver = observer
        registerObserverReceivedInvocations.append(observer)
        registerObserverClosure?(observer)
    }
}



