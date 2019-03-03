// swift-tools-version:4.2

import PackageDescription

let package = Package(
    name: "QTRoute",
    products: [
        .library(name: "QTRoute", targets: ["QTRoute"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(name: "QTRoute", dependencies: []),
        .testTarget(name: "QTRouteTests", dependencies: ["QTRoute"]),
    ]
)
