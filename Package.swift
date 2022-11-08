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
            url: "https://github.com/soulverteam/SoulverCore/releases/download/2.2.6/SoulverCore.xcframework.zip",
            checksum: "15a0f1833db9d0c4ab48279e9364cdf0b67d65245f6d4afac7f8e436a3be53fb"),
    ]
)
