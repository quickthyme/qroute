// swift-tools-version:4.2

import PackageDescription

let package = Package(
    name: "QRoute",
    products: [
        .library(name: "QRoute", targets: ["QRoute"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(name: "QRoute", dependencies: []),
        .testTarget(name: "QRouteTests", dependencies: ["QRoute"]),
    ]
)
