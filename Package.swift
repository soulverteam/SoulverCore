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
            url: "https://github.com/soulverteam/SoulverCore/releases/download/2.4.5/SoulverCore.xcframework.zip",
            checksum: "fe2600468b1068099deb8317f34d5d2e55f6e0f795aa21df389954bb1e6d699f"),
    ]
)
