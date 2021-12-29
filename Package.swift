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
            url: "https://github.com/soulverteam/SoulverCore/releases/download/1.4.3/SoulverCore.xcframework.zip",
            checksum: "010c9ab721106d078f1510bc997e94e76729864b17c3ff79ed3dcc227f0ca867"),
    ]
)
