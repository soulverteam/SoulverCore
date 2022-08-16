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
            url: "https://github.com/soulverteam/SoulverCore/releases/download/2.1.1/SoulverCore.xcframework.zip",
            checksum: "d4ff3104c116a662a5a2bceeda73ffaecbd39703a9b934596bb7d4c205a8ef37"),
    ]
)
