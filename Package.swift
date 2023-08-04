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
            url: "https://github.com/soulverteam/SoulverCore/releases/download/2.3.4/SoulverCore.xcframework.zip",
            checksum: "fc4972230c12bd22558d4b90ca60b1646f4e56bb97f5aa0475f8572b96096ab6"),
    ]
)
