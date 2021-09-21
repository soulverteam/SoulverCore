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
            url: "https://github.com/soulverteam/SoulverCore/releases/download/1.4.2/SoulverCore.xcframework.zip",
            checksum: "25235e6f60129bf02205922a20e9a547ae510da2f2a2c10e1c3d8dbc982cc8d7"),
    ]
)
