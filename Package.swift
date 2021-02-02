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
            url: "https://github.com/soulverteam/SoulverCore/releases/download/1.2.0/SoulverCore.xcframework.zip",
            checksum: "bfde93a1070e905c7d2737e14f50f4e7b7e01cc9daf963f0ea7628a4f7138d6c"),
    ]
)
