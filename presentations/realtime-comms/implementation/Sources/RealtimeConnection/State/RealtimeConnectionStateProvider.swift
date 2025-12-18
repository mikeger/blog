//
//  Copyright © 2025 Delivery Hero SE. All rights reserved.
//

import CommonDomain

public extension Realtime {
    protocol ConnectionStateProvider: AnyObject {
        func stateStream() async -> AsyncMulticastStream<ConnectionState>
        func publishState(_ state: ConnectionState)
        func state() async -> ConnectionState
    }

    final actor ConnectionStateProviderImpl: ConnectionStateProvider {
        private let stateMulticastStream: AsyncMulticastStream<ConnectionState>
        private let stateContinuation: AsyncMulticastStream<ConnectionState>.Continuation
        private var latestState: ConnectionState = .idle

        init() {
            let (stream, continuation) = AsyncMulticastStream<ConnectionState>.makeStream()
            self.stateMulticastStream = stream
            self.stateContinuation = continuation
            continuation.yield(.idle)
        }

        deinit {
            stateContinuation.finish()
        }

        public func stateStream() -> AsyncMulticastStream<ConnectionState> {
            stateMulticastStream
        }

        public nonisolated func publishState(_ state: ConnectionState) {
            stateContinuation.yield(state)
            Task {
                await update(to: state)
            }
        }

        private func update(to state: ConnectionState) async {
            latestState = state
        }

        public func state() async -> Realtime.ConnectionState {
            latestState
        }
    }
}
