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
            url: "https://github.com/soulverteam/SoulverCore/releases/download/3.2.1/SoulverCore.xcframework.zip",
            checksum: "9b5e04b4ba60a7a8438a056a5e410c50260e3c52cc0c817e0a8946449d7615ba"),
    ]
)
