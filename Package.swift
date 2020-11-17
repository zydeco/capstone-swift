// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Capstone",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Capstone",
            targets: ["Capstone"]
        )
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        .systemLibrary(name: "Ccapstone",
                       pkgConfig: "capstone",
                       providers: [
                        .brew(["capstone"])
        ]),
        .target(
            name: "Capstone",
            dependencies: ["Ccapstone"]),
        .testTarget(
            name: "CapstoneTests",
            dependencies: ["Capstone"])
    ]
)
