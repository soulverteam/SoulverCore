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
            url: "https://github.com/soulverteam/SoulverCore/releases/download/3.3.0/SoulverCore.xcframework.zip",
            checksum: "cdb358ed304a93d30892722b2339d3e15cc001caefe5cf77266faad70de8dfe8"),
    ]
)
