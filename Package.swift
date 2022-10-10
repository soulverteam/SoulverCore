// swift-tools-version:5.6

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
            url: "https://github.com/soulverteam/SoulverCore/releases/download/2.2.3/SoulverCore.xcframework.zip",
            checksum: "337bd8f66f9d655d505de67a6df49c2ad3470699973f5ea408fd6d30fda19cfe"),
    ]
)
