// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "cstool",
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(name:"Capstone", url: "https://github.com/zydeco/capstone-swift", .branch("next")),
        .package(url: "https://github.com/apple/swift-argument-parser", .upToNextMinor(from: "0.3.0"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "cstool",
            dependencies: [
                "Capstone",
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ]),
        .testTarget(
            name: "cstoolTests",
            dependencies: ["cstool"])
    ]
)
