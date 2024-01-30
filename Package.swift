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
            url: "https://github.com/soulverteam/SoulverCore/releases/download/2.4.7/SoulverCore.xcframework.zip",
            checksum: "44bae8eda439988e5d782b0ac81c595b66662f8d569f29af46413e3152917d86"),
    ]
)
