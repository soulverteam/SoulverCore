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
            url: "https://github.com/soulverteam/SoulverCore/releases/download/1.4.0/SoulverCore.xcframework.zip",
            checksum: "f67706273fb7ec8c7b2e60e6f2b1c0126ca20891daf5758e57244ec6d57a1d82"),
    ]
)
