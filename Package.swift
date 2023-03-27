// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "SoulverCore",
    products: [
        .library(
            name: "SoulverCore",
            targets: ["SoulverCore"]),
    ],
    targets: [
        .binaryTarget(
            name: "SoulverCore",
            url: "https://github.com/soulverteam/SoulverCore/releases/download/2.3.0/SoulverCore.xcframework.zip",
            checksum: "47eb2a4cd887f85b31c804ff8438751c46995f0f5cb7fe8ff09b8cbdef16ba4a"),
    ]
)
