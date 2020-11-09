// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "KeyboardView",
    platforms: [.iOS(.v11)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "KeyboardView",
            targets: ["KeyboardView"]),
    ],
    dependencies: [
        .package(url: "https://github.com/danielsaidi/KeyboardKit.git", from: "3.1.1")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "KeyboardView",
            dependencies: ["KeyboardKit"]),
        .testTarget(
            name: "KeyboardViewTests",
            dependencies: ["KeyboardView"]),
    ]
)
