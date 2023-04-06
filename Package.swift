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
            url: "https://github.com/soulverteam/SoulverCore/releases/download/2.3.1/SoulverCore.xcframework.zip",
            checksum: "d71fa674c7172978da26fe81529b6007d5c65a73e72e0cf0a7b1e7fc6dc51028"),
    ]
)
