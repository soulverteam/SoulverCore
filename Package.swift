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
            url: "https://github.com/soulverteam/SoulverCore/releases/download/2.4.3/SoulverCore.xcframework.zip",
            checksum: "94165409688e43c31ddec0b6b9de57767558cd63012d5bddbffb260b6e1e0cc7"),
    ]
)
