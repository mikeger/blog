//
//  Copyright © 2025 Delivery Hero SE. All rights reserved.
//

import Foundation

public extension Realtime {
    protocol Message {
        var metadata: Metadata { get }
    }

    struct Metadata: Codable {
        public let messageId: String?
        public let eventType: String?
        public let timestamp: Date?
        public let source: String?
        public let version: String?
    }

    struct OpaqueMessage: Message, CustomStringConvertible {
        public let metadata: Metadata
        fileprivate let payload: [String: Any]

        private static let isoFormatter: ISO8601DateFormatter = {
            let formatter = ISO8601DateFormatter()
            formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
            return formatter
        }()

        init(dictionary: [String: Any]) throws {
            self.payload = dictionary

            let metadata = dictionary["metadata"] as? [String: Any] ?? [:]
            let timestampString = metadata["timestamp"] as? String
            let source = metadata["source"] as? String

            let timestamp = timestampString.flatMap(OpaqueMessage.isoFormatter.date(from:)) ?? Date()
            let topLevelVersion = dictionary["version"] as? String // Deprecated
            self.metadata = Metadata(
                messageId: metadata["messageId"] as? String ?? UUID().uuidString,
                eventType: metadata["eventType"] as? String ?? "server:message",
                timestamp: timestamp,
                source: source,
                version: metadata["version"] as? String ?? topLevelVersion
            )
        }

        public var description: String {
            return "<OpaqueMessage type = \(metadata.eventType ?? "none") shouldUpdate = \(shouldUpdateRiderState) payload = '\(payload)'>"
        }
    }

    enum MessageVersion: String {
        case one = "1"
    }
}

extension Realtime.Message {
    var shouldUpdateRiderState: Bool {
        return metadata.version == Realtime.MessageVersion.one.rawValue
    }
}
