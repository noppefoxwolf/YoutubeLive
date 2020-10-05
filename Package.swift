// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "YoutubeLive",
    platforms: [.iOS(.v13)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "YoutubeLive",
            targets: ["YoutubeLive"]),
    ],
    dependencies: [
        .package(url: "https://github.com/groue/CombineExpectations.git", from: Version("0.5.0"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "YoutubeLive",
            dependencies: []),
        .testTarget(
            name: "YoutubeLiveTests",
            dependencies: ["YoutubeLive", "CombineExpectations"]),
    ]
)
