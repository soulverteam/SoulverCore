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
            url: "https://github.com/soulverteam/SoulverCore/releases/download/2.2.1/SoulverCore.xcframework.zip",
            checksum: "c1fc37e912413d1ad0f44e6d6f79b0c2c7baee4acf669df9f0490579f39b055d"),
    ]
)
