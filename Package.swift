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
            url: "https://github.com/soulverteam/SoulverCore/releases/download/3.0.0/SoulverCore.xcframework.zip",
            checksum: "2d5375c1dc438d0a8ab54a73c956cdf2fa7af1bc11d36501f56dff3f7168bccb"),
    ]
)
