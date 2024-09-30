// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Notification",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "Notification",
            targets: ["Notification"]),
    ],
    dependencies: [
        .package(name: "Firebase", url: "https://github.com/firebase/firebase-ios-sdk.git", from: "11.1.0")
    ],
    targets: [
        .target(
            name: "Notification",
            dependencies: [
                .product(name: "FirebaseMessaging", package: "Firebase"),
            ]
        )
    ]
)
