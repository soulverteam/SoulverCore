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
            url: "https://github.com/soulverteam/SoulverCore/releases/download/2.0.3/SoulverCore.xcframework.zip",
            checksum: "c2204146b962bdaf6a926204b2a06cb033853188cd838c1574c2181612703f1c"),
    ]
)
