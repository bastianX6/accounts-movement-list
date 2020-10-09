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
            name: "MovementList_iOS",
            targets: ["MovementList_iOS"]),
        .library(
            name: "MovementDetails_iOS",
            targets: ["MovementDetails_iOS"]),
    ],
    dependencies: [
        .package(name: "DataManagement",
                 url: "https://github.com/bastianX6/accounts-data-management.git",
                 from: "1.0.1"),
        .package(name: "AccountsUI",
                 url: "https://github.com/bastianX6/accounts-ui.git",
                 from: "1.0.2"),
        .package(name: "NewMovement",
                 url: "https://github.com/bastianX6/accounts-new-movement.git",
                 from: "1.0.0"),
        .package(name: "DependencyResolver",
                 url: "https://github.com/bastianX6/accounts-dependency-resolver",
                 from: "0.1.0"),
    ],
    targets: [
        .target(
            name: "MovementListCommon",
            dependencies: [
                "DataManagement",
                "AccountsUI",
                "DependencyResolver"
            ],
            resources: [.process("Resources")]
        ),
        .target(
            name: "MovementList_iOS",
            dependencies: [
                "DataManagement",
                "AccountsUI",
                "MovementListCommon",
                "MovementDetails_iOS"
            ],
            resources: [.process("Resources")]
        ),
        .target(
            name: "MovementDetails_iOS",
            dependencies: [
                "DataManagement",
                "AccountsUI",
                "MovementListCommon",
                .product(name: "NewMovement_iOS", package: "NewMovement")
            ],
            resources: [.process("Resources")]
        ),
        .testTarget(
            name: "MovementListCommonTests",
            dependencies: ["MovementListCommon"]
        )
    ]
)
