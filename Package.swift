// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-plugin",
    platforms: [
      .macOS(.v12)
    ],
    products: [
        .library(
            name: "Plugin",
            targets: ["Plugin"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "Plugin",
            dependencies: []),
    ]
)
