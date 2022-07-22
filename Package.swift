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
        
    ],
    targets: [
        .target(
            name: "KeychainWrapper"
        ),
        .testTarget(
            name: "KeychainWrapperTests",
            dependencies: [
                "KeychainWrapper"
            ]
        )
    ]
)
