// swift-tools-version:5.6

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
            url: "https://github.com/soulverteam/SoulverCore/releases/download/2.2.2/SoulverCore.xcframework.zip",
            checksum: "1a31a944a11a7f930ac155dc094b52aba92d2a0885eb471983816411d603e024"),
    ]
)
