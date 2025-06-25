// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MidoconlineiOSSDK",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "MidoconlineiOSSDK",
            targets: ["MidoconlineiOSSDK"])
    ],
    targets: [
        .target(
            name: "MidoconlineiOSSDK",
            path: "Sources",
            resources: [.process("Resources")])
    ]
)
