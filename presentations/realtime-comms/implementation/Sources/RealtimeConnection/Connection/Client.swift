//
//  Copyright © 2025 Delivery Hero SE. All rights reserved.
//

import CommonDomain

public extension Realtime {
    // sourcery: AutoMockable
    protocol Client {
        func connect()
        func updateAuth(with token: Realtime.Token)
        func disconnect()
        var state: AsyncMulticastStream<Realtime.ClientState> { get }
        var message: AsyncMulticastStream<Realtime.Message> { get }
    }

    enum ClientState: Sendable {
        case idle
        case connecting
        case connected
        case disconnected
    }
}
