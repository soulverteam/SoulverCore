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
            url: "https://github.com/soulverteam/SoulverCore/releases/download/2.6.0/SoulverCore.xcframework.zip",
            checksum: "fc8ed1ff7fd915754c68e24bab644f037ec04298c1bf3cbba82ab950bbdcfec8"),
    ]
)
