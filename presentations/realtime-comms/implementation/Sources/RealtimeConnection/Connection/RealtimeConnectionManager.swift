//
//  Copyright © 2025 Delivery Hero SE. All rights reserved.
//

import CommonDomain
import Foundation

public extension Realtime {
    protocol ConnectionManager: AnyObject {
        func state() async -> AsyncMulticastStream<ConnectionState>
        func stop()
        func debugConfigurationSnapshot() -> DebugConfigurationSnapshot?
    }
}
