// swift-tools-version: 6.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BarkVM",
    products: [
        .library(name: "BarkVM", targets: ["BarkVM"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.2.0"),
    ],
    targets: [
        .target(name: "BarkVM"),
        .executableTarget(
            name: "Compiler",
            dependencies: [
                "BarkVM",
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ]
        ),
        .testTarget(
            name: "BarkVMTests",
            dependencies: ["BarkVM"]
        ),
    ],
    swiftLanguageModes: [.v6]
)
