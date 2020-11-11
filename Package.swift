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
            url: "https://github.com/soulverteam/SoulverCore/releases/download/1.1.5/SoulverCore.xcframework.zip",
            checksum: "4bd13105d27335e991bafd6fb795916e1e623f4ce345cd9750b8320380b36e43"),
    ]
)
