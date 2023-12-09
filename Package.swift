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
            url: "https://github.com/soulverteam/SoulverCore/releases/download/2.4.4/SoulverCore.xcframework.zip",
            checksum: "fb359657488becc762e6ec81943c4aab2b6533be4ef317ae181a3f72fc1c4484"),
    ]
)
