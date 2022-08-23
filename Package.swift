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
            url: "https://github.com/soulverteam/SoulverCore/releases/download/2.2.0/SoulverCore.xcframework.zip",
            checksum: "112aec3310ce1bbf7706d110c971151df8eae7108c687946e3fb70d31fa6d47f"),
    ]
)
