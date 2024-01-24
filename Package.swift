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
            url: "https://github.com/soulverteam/SoulverCore/releases/download/2.4.6/SoulverCore.xcframework.zip",
            checksum: "50df6f25bad23ba49ed2f805f227be1c22d7cd58db886cf820a61182e1f994a1"),
    ]
)
