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
            url: "https://github.com/soulverteam/SoulverCore/releases/download/3.2.0/SoulverCore.xcframework.zip",
            checksum: "2ac5cfac974a386ff4944f915b5b7a76433a3946986a4c624cad08fed25b5b9f"),
    ]
)
