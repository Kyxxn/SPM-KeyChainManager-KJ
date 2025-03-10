// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "KeyChainManager-KJ",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "KeyChainManager-KJ",
            targets: ["KeyChainManager-KJ"]),
    ],
    targets: [
        .target(
            name: "KeyChainManager-KJ"),

    ]
)
