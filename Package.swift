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
            url: "https://github.com/soulverteam/SoulverCore/releases/download/2.1.0/SoulverCore.xcframework.zip",
            checksum: "355b7a9a1c65ecca0e55f4e6efd1aaf3591957eac4f6a7f90348683079d0bc33"),
    ]
)
