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
            url: "https://github.com/soulverteam/SoulverCore/releases/download/2.3.2/SoulverCore.xcframework.zip",
            checksum: "4bc9c4d6e27fe1076704738af0591e767a651efcf762724170a21063254b599e"),
    ]
)
