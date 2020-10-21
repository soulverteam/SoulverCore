// swift-tools-version:5.3

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
            url: "https://github.com/soulverteam/SoulverCore/releases/download/1.1.3/SoulverCore.xcframework.zip",
            checksum: "ecd59c3fb1819809655f1dcee082212604a8ee54fff1ce084fde463b46bda445"),
    ]
)
