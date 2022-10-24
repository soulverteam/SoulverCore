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
            url: "https://github.com/soulverteam/SoulverCore/releases/download/2.2.4/SoulverCore.xcframework.zip",
            checksum: "3710ac8bcd0132da00c614ba357ab9f773fb1e2ea712bf3f7d96f59564b33e6a"),
    ]
)
