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
            url: "https://github.com/soulverteam/SoulverCore/releases/download/2.0.1/SoulverCore.xcframework.zip",
            checksum: "4f1e728ef334a88b2ffdb007c2101608ee768abaaceb06d797ceaa3c5a1baab2"),
    ]
)
