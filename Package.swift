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
            url: "https://github.com/soulverteam/SoulverCore/releases/download/2.0.2/SoulverCore.xcframework.zip",
            checksum: "8a2e4403e3d1cc69d5de46b51746d5c049725d26b5d7f9a58787c595fde47ed5"),
    ]
)
