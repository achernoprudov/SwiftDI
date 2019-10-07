// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftDI",
    platforms: [
        .macOS(.v10_10),
        .iOS(.v8),
        .tvOS(.v9),
        .watchOS(.v2),
    ],
    products: [
        .library(
            name: "SwiftDI",
            targets: ["SwiftDI"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/Quick/Quick.git", from: "2.1.0"),
        .package(url: "https://github.com/Quick/Nimble.git", from: "8.0.2"),
    ],
    targets: [
        .target(
            name: "SwiftDI",
            dependencies: []
        ),
        .testTarget(
            name: "SwiftDITests",
            dependencies: ["SwiftDI", "Quick", "Nimble"]
        ),
    ],
    swiftLanguageVersions: [.v5]
)
