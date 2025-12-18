//
//  Copyright © 2025 Delivery Hero SE. All rights reserved.
//

import DependencyInjection
import Foundation
import Networking

public extension Realtime {
    struct ConnectionAssembly: Assembly {
        public init() {}
        public func assemble(with container: Container) {
            container.register(Realtime.ConnectionStateProvider.self) { _ in
                ConnectionStateProviderImpl()
            }

            container.register(RealtimeConnectionHandle.self) { _ in
                RealtimeConnectionHandle()
            }.scope(.singleton)

            container.register(Realtime.Client.self) { (resolver, configuration: ConnectionConfiguration) in
                Realtime.SocketIOClient(socketURL: configuration.gatewayURL, headerProvider: resolver.resolve())
            }

            container.register(Realtime.ConnectionManager.self) { resolver, configuration in
                Realtime.ConnectionManagerImpl(
                    configuration: configuration,
                    client: resolver.resolve(with: configuration),
                    authTokenProvider: resolver.resolve(),
                    riderHomeDataService: resolver.resolve(),
                    stateValidityManager: resolver.resolve(),
                    appStateObserver: resolver.resolve(name: ServiceName.appStateObserverV2),
                    stateProvider: resolver.resolve()
                )
            }

            container.register(Realtime.DebugViewControllerType.self) { resolver, connectionManager in
                Realtime.DebugViewController(
                    connectionManager: connectionManager,
                    localNotificationStatusProvider: resolver.resolveOptional()
                )
            }
        }
    }
}
