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
            url: "https://github.com/soulverteam/SoulverCore/releases/download/2.2.8/SoulverCore.xcframework.zip",
            checksum: "7c8a29f3c00a5bd68344fa0517351ea0d19262feb2e2aefbf0256b1c2781c286"),
    ]
)
