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
            checksum: "90b4b9b13880944da3b2d8e72d0b3cd8d66cffaf2b679af3222510e3925111df"),
    ]
)
