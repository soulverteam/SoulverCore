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
            url: "https://github.com/soulverteam/SoulverCore/releases/download/2.2.10/SoulverCore.xcframework.zip",
            checksum: "53e18cde56823982d3b4cd1a49aa66310c1735c5687decdbfae6347a9397c44b"),
    ]
)
