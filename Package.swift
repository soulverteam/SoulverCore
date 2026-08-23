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
            url: "https://github.com/soulverteam/SoulverCore/releases/download/3.5.1/SoulverCore.xcframework.zip",
            checksum: "36e51abc2d22b2f1000ceeb4468cfa9ce74f4cf3fb79097f7f3e004b7bf9e7c7"),
    ]
)
