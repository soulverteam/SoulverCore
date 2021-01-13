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
            url: "https://github.com/soulverteam/SoulverCore/releases/download/1.1.7/SoulverCore.xcframework.zip",
            checksum: "624944f13fbe7eb07bfd330f6a8e159f2b60caec579340bca56ca273e260037f"),
    ]
)
