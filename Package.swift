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
            url: "https://github.com/soulverteam/SoulverCore/releases/download/2.5.0/SoulverCore.xcframework.zip",
            checksum: "b31998d3bcabe0aa694540e085ef0635075da951fd23841603b2269a9d2e1bbd"),
    ]
)
