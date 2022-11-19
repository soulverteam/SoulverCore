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
            url: "https://github.com/soulverteam/SoulverCore/releases/download/2.2.7/SoulverCore.xcframework.zip",
            checksum: "659264fe5e37abb2c152d7bb10757b008ff33360fec89d68288b003ad4d5c057"),
    ]
)
