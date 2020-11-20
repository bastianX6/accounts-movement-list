// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MovementList",
    defaultLocalization: "es",
    platforms: [
        .iOS(.v14),
        .tvOS(.v14),
        .macOS(.v10_15),
        .watchOS(.v7)
    ],
    products: [
        .library(
            name: "MovementList",
            targets: ["MovementList"]
        )
    ],
    dependencies: [
        .package(path: "./MovementList_iOS"),
        .package(path: "./MovementDetails_iOS"),
    ],
    targets: [
        .target(
            name: "MovementList",
            dependencies: [
                .product(
                    name: "MovementList_iOS",
                    package: "MovementList_iOS",
                    condition: .when(platforms: [.iOS])
                ),
                .product(
                    name: "MovementDetails_iOS",
                    package: "MovementDetails_iOS",
                    condition: .when(platforms: [.iOS])
                )
            ]
        )
    ]
)
