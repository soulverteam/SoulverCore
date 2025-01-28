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
            url: "https://github.com/soulverteam/SoulverCore/releases/download/3.1.0/SoulverCore.xcframework.zip",
            checksum: "5df48563d102e13259dfdf267b762731ba862c9183d0802f8875d83e2c9ec0df"),
    ]
)
