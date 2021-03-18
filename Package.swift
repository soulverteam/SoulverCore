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
            url: "https://github.com/soulverteam/SoulverCore/releases/download/1.3.1/SoulverCore.xcframework.zip",
            checksum: "4ee4b40a4e67218639fb54de030934d37eb1c76228459857ab4972870d33d078"),
    ]
)
