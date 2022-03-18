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
            url: "https://github.com/soulverteam/SoulverCore/releases/download/1.4.4/SoulverCore.xcframework.zip",
            checksum: "c199a89ee98fa3afb8a261508e600330a7968d6590e523bc49594131d1f62a08"),
    ]
)
