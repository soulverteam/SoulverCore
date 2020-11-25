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
            url: "https://github.com/soulverteam/SoulverCore/releases/download/1.1.6/SoulverCore.xcframework.zip",
            checksum: "0c96dbe5ccd5a9d0c74aee6f8c619905b5d23359c47caae8cb067bd668a94ced"),
    ]
)
