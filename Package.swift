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
            url: "https://github.com/soulverteam/SoulverCore/releases/download/1.4.1/SoulverCore.xcframework.zip",
            checksum: "9b183afc202cb352f8cbdb86757177c5fe6f90968d3c5444a9f1325476ba4cdd"),
    ]
)
