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
            url: "https://github.com/soulverteam/SoulverCore/releases/download/2.2.9/SoulverCore.xcframework.zip",
            checksum: "84d78ae3c40e416aca0e524602824030671b7e180142364e338099c525334a3d"),
    ]
)
