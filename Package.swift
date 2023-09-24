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
            url: "https://github.com/soulverteam/SoulverCore/releases/download/2.4.0/SoulverCore.xcframework.zip",
            checksum: "3495089391596ebf8377ffaa69bea13fb96673117105303dd4f48ad3994a42b7"),
    ]
)
