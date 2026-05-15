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
            url: "https://github.com/soulverteam/SoulverCore/releases/download/3.5.0/SoulverCore.xcframework.zip",
            checksum: "b4a590dc75c6855c4a51dcb14a230333579aa5ad898e6825e697b8f02ebb55e7"),
    ]
)
