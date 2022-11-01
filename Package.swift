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
            url: "https://github.com/soulverteam/SoulverCore/releases/download/2.2.5/SoulverCore.xcframework.zip",
            checksum: "0eddd4a3c6af43ae2f16cd8ff44acfe431a5053e3197a35372ccce2206b16ef2"),
    ]
)
