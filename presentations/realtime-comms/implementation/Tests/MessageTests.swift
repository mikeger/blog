//
//  Copyright © 2025 Delivery Hero SE. All rights reserved.
//

import Testing
@testable import RealtimeConnection
import Foundation

@Suite
struct MessageTests {
    @Test
    func testUpdateOnFirstVersion() async throws {
        let message = try Realtime.OpaqueMessage(dictionary: ["version": "1"])
        
        assert(message.shouldUpdateRiderState == true)
    }
    
    @Test
    func testNoUpdateOnOtherVersion() async throws {
        let message = try Realtime.OpaqueMessage(dictionary: ["version": "2"])
        
        assert(message.shouldUpdateRiderState == false)
    }

    @Test
    func testVersionReadFromMetadataIfTopLevelMissing() async throws {
        let payload: [String: Any] = [
            "metadata": [
                "eventType": "delivery_completed",
                "timestamp": "2025-11-26T10:06:20.294+01:00",
                "source": "delivery",
                "version": "1"
            ],
            "payload": [
                "orderCode": "falc-4825-q6m4",
                "deliveryId": 119362112205924288,
                "userId": 1368550
            ]
        ]
        let message = try Realtime.OpaqueMessage(dictionary: payload)

        assert(message.metadata.version == "1")
        assert(message.shouldUpdateRiderState == true)
        assert(message.metadata.eventType == "delivery_completed")
        assert(message.metadata.source == "delivery")

        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        let expectedTimestamp = formatter.date(from: "2025-11-26T10:06:20.294+01:00")
        assert(message.metadata.timestamp == expectedTimestamp)
    }

    @Test
    func testMetadataDefaultValues() async throws {
        let payload: [String: Any] = [
            "metadata": [
                "source": "delivery"
            ],
            "payload": [:]
        ]
        let message = try Realtime.OpaqueMessage(dictionary: payload)

        assert(message.metadata.messageId != nil)
        assert(message.metadata.eventType == "server:message")
        assert(message.metadata.timestamp != nil)
    }
}
