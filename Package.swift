// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NamesGenerator",
    products: [
        .library(
            name: "NamesGenerator",
            targets: ["NamesGenerator"]),
    ],
    dependencies: [
        .package(url: "https://github.com/jpsim/Yams.git", "5.0.0"..<"6.0.0")
    ],
    targets: [
        .target(
            name: "NamesGenerator",
            dependencies: [.product(name: "Yams", package: "Yams")],
            resources: [.copy("Resources/adjectives.yml"),
                        .copy("Resources/animals.yml"),
                        .copy("Resources/colors.yml"),
                        .copy("Resources/star_wars.yml"),
                        .copy("Resources/stars.yml"),
                        .copy("Resources/westeros.yml"),
                        .copy("Resources/witcher.yml")]),
        .testTarget(
            name: "NamesGeneratorTests",
            dependencies: ["NamesGenerator"]),
    ]
)
