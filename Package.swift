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
            url: "https://github.com/soulverteam/SoulverCore/releases/download/2.6.3/SoulverCore.xcframework.zip",
            checksum: "a2ebeaa65502f9b2f8a8d4ba1c92e0180a95255a39034d71c2cc979bc10666d4"),
    ]
)
