//
//  Copyright © 2025 Delivery Hero SE. All rights reserved.
//

import Foundation

public protocol AsyncDelayType {
    func sleep(seconds: TimeInterval) async
}

public struct AsyncDelayProvider: AsyncDelayType {
    public init() {}
    public func sleep(seconds: TimeInterval) async {
        guard seconds > 0 else { return }
        let nanoseconds = UInt64(seconds * 1_000_000_000)
        try? await Task.sleep(nanoseconds: nanoseconds)
    }
}
