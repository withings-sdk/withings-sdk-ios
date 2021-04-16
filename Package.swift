// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Withings",
    platforms: [.iOS(.v12)],
    products: [
        .library(name: "Withings", targets: ["Withings"]),
    ],
    targets: [
        .binaryTarget(name: "Withings", path: "Withings.xcframework")
    ]
)
