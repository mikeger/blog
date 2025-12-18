// swift-tools-version:5.8
import PackageDescription

let package = Package(
    name: "RealtimeConnection",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "RealtimeConnection",
            targets: ["RealtimeConnection"]
        )
    ],
    dependencies: [
        .package(path: "../DependencyInjection"),
        .package(path: "../AppExtensions/Shared/Logging"),
        .package(path: "../CommonDomain"),
        .package(path: "../Networking"),
        .package(path: "../Localizations"),
        .package(path: "../DeliveryFlow/DeliveryCommon"),
        .package(path: "../Status/StatusInterface"),
        .package(path: "../RiderHomeService"),
        .package(
            url: "https://github.com/socketio/socket.io-client-swift.git",
            .upToNextMajor(from: "16.0.0")
        )
    ],
    targets: [
        .target(
            name: "RealtimeConnection",
            dependencies: [
                "DependencyInjection",
                "Logging",
                "CommonDomain",
                "Networking",
                "DeliveryCommon",
                .product(name: "SocketIO", package: "socket.io-client-swift")
            ],
            path: "Sources"
        ),
        .testTarget(
            name: "RealtimeConnection-UnitTests",
            dependencies: [
                "RealtimeConnection",
                .product(name: "CommonDomainTesting", package: "CommonDomain"),
                "DependencyInjection",
                "Localizations",
                "Networking",
                .product(name: "SocketIO", package: "socket.io-client-swift"),
                "CommonDomain",
                .product(name: "RiderHomeServiceInterface", package: "RiderHomeService"),
                "DeliveryCommon",
                "StatusInterface"
            ],
            path: "Tests"
        )
    ]
)
