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
            url: "https://github.com/soulverteam/SoulverCore/releases/download/2.7.1/SoulverCore.xcframework.zip",
            checksum: "c875356ccafc515d007ae89ab9947a03e6774080941b61a98a7084c5a141f079"),
    ]
)
