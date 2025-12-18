//
//  Copyright © 2025 Delivery Hero SE. All rights reserved.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "RealtimeConnection",
    options: .options(disableSynthesizedResourceAccessors: true),
    targets: [
        .target(
            name: "RealtimeConnection",
            destinations: .iOS,
            product: .staticFramework,
            bundleId: "com.logistics.rider.RealtimeConnection",
            deploymentTargets: .riderAppDefault,
            buildableFolders: ["Sources/"],
            dependencies: [
                .dependencyInjection,
                .logging,
                .commonDomain,
                .networking,
                .deliveryCommon,
                .external(name: "SocketIO")
            ],
            settings: .objcDependencyTarget,
            metadata: .ownershipBased()
        ),
        .target(
            name: "RealtimeConnection-UnitTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "com.logistics.rider.RealtimeConnection-UnitTests",
            deploymentTargets: .riderAppDefault,
            buildableFolders: ["Tests/"],
            dependencies: [
                .target(name: "RealtimeConnection"),
                .external(name: "SocketIO"),
                .commonDomainTesting,
                .commonDomain,
                .riderHomeServiceInterface,
                .deliveryCommon,
                .dependencyInjection,
                .localizations,
                .networking,
                .statusInterface
            ],
            settings: .objcDependencyTarget,
            metadata: .ownershipBased()
        )
    ]
)
