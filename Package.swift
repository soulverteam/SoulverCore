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
            url: "https://github.com/soulverteam/SoulverCore/releases/download/3.4.0/SoulverCore.xcframework.zip",
            checksum: "3f72e72b35f88b9608d53d74717c9362fb7e9d88b31b6476640a10957b8e5d6c"),
    ]
)
