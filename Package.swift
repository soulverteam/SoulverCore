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
            url: "https://github.com/soulverteam/SoulverCore/releases/download/3.0.0/SoulverCore.xcframework.zip",
            checksum: "899988bbf0444dd4db303f5bbc88f2f6b5a0ca58ab4e878b7ecabcef5aa8ab43"),
    ]
)
