//
//  Copyright © 2025 Delivery Hero SE. All rights reserved.
//

import Foundation

public extension Realtime {
    // sourcery: AutoMockable
    protocol ConnectionConfiguration {
        var realtimeConnectionEnabled: Bool { get }
        var reconnectOnTokenExpiration: Bool { get }
        var gatewayURL: URL { get }
        var reconnectConfiguration: Realtime.ReconnectConfiguration { get }
    }

    protocol ReconnectConfiguration {
        var foregroundReconnectDelay: TimeInterval { get }
        var offlinePollInterval: TimeInterval { get }
        var backoffMultiplier: Double { get }
        var maxBackoffDelay: TimeInterval { get }
        var maxReconnectAttempts: Int { get }
        var initialBackoffDelay: TimeInterval { get }
    }

    struct ReconnectConfigurationStruct: ReconnectConfiguration {
        public init() {}

        public var foregroundReconnectDelay: TimeInterval = 10
        public var offlinePollInterval: TimeInterval = 2
        public var backoffMultiplier: Double = 2
        public var maxBackoffDelay: TimeInterval = 32
        public var maxReconnectAttempts: Int = 6
        public var initialBackoffDelay: TimeInterval = 1
    }
}
