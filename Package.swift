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
            url: "https://github.com/soulverteam/SoulverCore/releases/download/2.6.2/SoulverCore.xcframework.zip",
            checksum: "fb0cbb25ea67eea22d75a41e73341c6b1869299a0d6bb7460780db425186022f"),
    ]
)
