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
            url: "https://github.com/soulverteam/SoulverCore/releases/download/2.3.3/SoulverCore.xcframework.zip",
            checksum: "b1ebf5a5f76cc4a61fc84d5c11a725c2cc8032c5733c2384cb3f92d18b6ecd2e"),
    ]
)
