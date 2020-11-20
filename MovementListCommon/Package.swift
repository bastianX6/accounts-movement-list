// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MovementListCommon",
    platforms: [
        .iOS(.v14),
        .tvOS(.v14),
        .macOS(.v10_15),
        .watchOS(.v7)
    ],
    products: [
        .library(
            name: "MovementListCommon",
            targets: ["MovementListCommon"]),
    ],
    dependencies: [
        .package(name: "DataManagement",
                 url: "https://github.com/bastianX6/accounts-data-management.git",
                 from: "1.0.1"),
        .package(name: "AccountsUI",
                 url: "https://github.com/bastianX6/accounts-ui.git",
                 from: "1.0.2"),
    ],
    targets: [
        .target(
            name: "MovementListCommon",
            dependencies: [
                "DataManagement",
                "AccountsUI",
            ],
            resources: [.process("Resources")]
        ),
        .testTarget(
            name: "MovementListCommonTests",
            dependencies: ["MovementListCommon"]
        )
    ]
)
