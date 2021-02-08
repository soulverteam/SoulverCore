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
            url: "https://github.com/soulverteam/SoulverCore/releases/download/1.2.1/SoulverCore.xcframework.zip",
            checksum: "564cf25c293b0cc778525d94acf2b8119f60fab707f5ce614b1f5406e17957f0"),
    ]
)
