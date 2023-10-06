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
            url: "https://github.com/soulverteam/SoulverCore/releases/download/2.4.2/SoulverCore.xcframework.zip",
            checksum: "d7fc1fa2cbbef8bed373194ae69b78645d5ae3f0e26536189682ef62c2e91946"),
    ]
)
