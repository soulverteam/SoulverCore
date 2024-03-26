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
            url: "https://github.com/soulverteam/SoulverCore/releases/download/2.6.1/SoulverCore.xcframework.zip",
            checksum: "d48578397233584ce73280583b74a54d317e5151b501e6ac429fdb29e1cacd5c"),
    ]
)
