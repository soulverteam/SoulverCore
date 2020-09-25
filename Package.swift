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
            url: "https://github.com/soulverteam/SoulverCore/releases/download/1.1.2/SoulverCore.xcframework.zip",
            checksum: "9eb58b5fd1eda5157734dee414a8715f695dfac2e1a2c29364c5a6fecc118675"),
    ]
)
