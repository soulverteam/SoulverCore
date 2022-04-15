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
            url: "https://github.com/soulverteam/SoulverCore/releases/download/2.0.0/SoulverCore.xcframework.zip",
            checksum: "642338ec78d828d95b45c54c0e1c2de33b5fb8b9ba57d4d31c8e3effd66d8f99"),
    ]
)
