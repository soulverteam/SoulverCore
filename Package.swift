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
            url: "https://github.com/soulverteam/SoulverCore/releases/download/1.4.5/SoulverCore.xcframework.zip",
            checksum: "4e3eeb72c8326d1d1002d29d4f69dffe5ef4e7995cd78cc5138e1f30cf9f4bb5"),
    ]
)
