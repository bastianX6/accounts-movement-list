// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MovementList_iOS",
    defaultLocalization: "es",
    platforms: [
        .iOS(.v14),
    ],
    products: [
        .library(
            name: "MovementList_iOS",
            targets: ["MovementList_iOS"]
        ),
    ],
    dependencies: [
        .package(name: "DataManagement",
                 url: "https://github.com/bastianX6/accounts-data-management.git",
                 from: "1.0.1"),
        .package(name: "AccountsUI",
                 url: "https://github.com/bastianX6/accounts-ui.git",
                 from: "1.0.2"),
        .package(name: "DependencyResolver",
                 url: "https://github.com/bastianX6/accounts-dependency-resolver",
                 from: "1.0.0"),
        .package(path: "../MovementListCommon"),
        .package(path: "../MovementDetails_iOS"),
    ],
    targets: [
        .target(
            name: "MovementList_iOS",
            dependencies: [
                "DataManagement",
                "AccountsUI",
                "MovementListCommon",
                "MovementDetails_iOS",
                "DependencyResolver",
            ],
            resources: [.process("Resources")]
        ),
        .testTarget(
            name: "MovementList.iOS.Tests",
            dependencies: ["MovementList_iOS"]
        )
    ]
)
