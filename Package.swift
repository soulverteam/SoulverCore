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
            url: "https://github.com/soulverteam/SoulverCore/releases/download/1.1.2/SoulverCore.xcframework.zip",
            checksum: "7eeeff4e925faf039fd22eb5d208dd2aac344821a910483ebe3f1921ebd46953"),
    ]
)
