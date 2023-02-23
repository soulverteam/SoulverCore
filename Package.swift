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
            url: "https://github.com/soulverteam/SoulverCore/releases/download/2.2.11/SoulverCore.xcframework.zip",
            checksum: "d423462fd530e1f16b9c687e5e48de884e95c75183bf1da335406da5d115de0f"),
    ]
)
