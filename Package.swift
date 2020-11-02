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
            url: "https://github.com/soulverteam/SoulverCore/releases/download/1.1.4/SoulverCore.xcframework.zip",
            checksum: "3455794578c7978defd8c572e83e5426075f4f1bbed9a32b2db6047a9d58de83"),
    ]
)
