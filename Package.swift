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
            url: "https://github.com/soulverteam/SoulverCore/releases/download/1.3.0/SoulverCore.xcframework.zip",
            checksum: "ba50b37c78f84b359c94ba541ca0b7aa4d46381dd45181f1ee099b867c3e7464"),
    ]
)
