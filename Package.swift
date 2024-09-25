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
            url: "https://github.com/soulverteam/SoulverCore/releases/download/2.7.0/SoulverCore.xcframework.zip",
            checksum: "4691d80829213035362697fa09f3b429a2f7d9d84989456399d5416e941f46ce"),
    ]
)
