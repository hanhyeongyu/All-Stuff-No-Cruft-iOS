// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Platform",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "AppUtil",
            targets: ["AppUtil"]
        ),
        .library(
            name: "Networks",
            targets: ["Networks"]),
        .library(
            name: "UIUtil",
            targets: ["UIUtil"]
        ),
        .library(
            name: "LogUtil",
            targets: ["LogUtil"]
        ),
        .library(
            name: "CombineUtil",
            targets: ["CombineUtil"]),
        .library(
            name: "Preference",
            targets: ["Preference"]
        )
    ],
    dependencies: [        
        .package(name: "Firebase", url: "https://github.com/firebase/firebase-ios-sdk.git", from: "11.1.0"),
        .package(url: "https://github.com/CocoaLumberjack/CocoaLumberjack.git", from: "3.8.0"),
        .package(url: "https://github.com/CombineCommunity/CombineExt", from: "1.8.1"),
        .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.9.1")),
        .package(url: "https://github.com/onevcat/Kingfisher.git", from: "7.0.0")
    ],
    targets: [
        .target(
            name: "AppUtil",
            dependencies: [
                "LogUtil"
            ]
        ),
        .target(
            name: "Networks",
            dependencies: [
                "Preference",
                "AppUtil",
                .product(name: "Alamofire", package: "Alamofire"),
                .product(name: "CocoaLumberjack", package: "CocoaLumberjack"),
                .product(name: "CocoaLumberjackSwift", package: "CocoaLumberjack")
            ]
        ),
        .target(
            name: "UIUtil",
            dependencies: [
                .product(name: "Kingfisher", package: "Kingfisher"),
                "AppUtil",
                "CombineUtil"
            ]
        ),
        .target(
            name: "LogUtil",
            dependencies: [
                "CocoaLumberjack",
                .product(name: "CocoaLumberjackSwift", package: "CocoaLumberjack"),
                
                .product(name: "FirebaseCrashlytics", package: "Firebase"),
                .product(name: "FirebaseAnalytics", package: "Firebase"),                
            ]
        ),
        .target(
            name: "CombineUtil",
            dependencies: [
                "CombineExt",
            ]
        ),
        .target(
            name: "Preference",
            dependencies: [
                "LogUtil"
            ]
        )
    ]
)
