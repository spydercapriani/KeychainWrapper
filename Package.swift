// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "KeychainWrapper",
    platforms: [
        .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "KeychainWrapper",
            targets: [
                "KeychainWrapper"
            ]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/console-kit.git", from: "4.4.1"),
    ],
    targets: [
        .target(
            name: "KeychainWrapper"
        ),
        .executableTarget(
            name: "App",
            dependencies: [
                "KeychainWrapper",
                .product(name: "ConsoleKit", package: "console-kit"),
            ]
        ),
        .testTarget(
            name: "KeychainWrapperTests",
            dependencies: [
                "KeychainWrapper"
            ]
        )
    ]
)
