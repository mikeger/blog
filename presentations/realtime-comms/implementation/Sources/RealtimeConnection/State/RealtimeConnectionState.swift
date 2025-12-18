//
//  Copyright © 2025 Delivery Hero SE. All rights reserved.
//

import Foundation
import UIKit

public extension Realtime {
    enum ConnectionState: String, Equatable, Sendable {
        case idle
        case connecting
        case synchronizing
        case connected
        case disconnected
        case failed

        var readyToReconnect: Bool {
            switch self {
            case .idle, .disconnected, .failed:
                return true
            case .connecting, .synchronizing, .connected:
                return false
            }
        }
    }
}

public extension Realtime.ConnectionState {
    var debugDisplayTitle: String {
        rawValue.replacingOccurrences(of: "_", with: " ").capitalized
    }

    var indicatorColor: UIColor {
        switch self {
        case .connected:
            return .systemGreen
        case .synchronizing:
            return .systemTeal
        case .connecting:
            return .systemOrange
        case .disconnected:
            return .systemRed
        case .failed:
            return .systemPink
        case .idle:
            return .systemGray
        }
    }
}
