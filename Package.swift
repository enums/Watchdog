// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Watchdog",
    products: [
        .executable(
            name: "Watchdog",
            targets: ["Watchdog"]),
        ],
    dependencies: [
        .package(url:"https://github.com/enums/Pjango.git" , from: "2.1.0"),
        .package(url:"https://github.com/PerfectlySoft/Perfect-CURL.git" , from: "3.1.0"),
        ],
    targets: [
        .target(
            name: "Watchdog",
            dependencies: [
                "Pjango",
                "PerfectCURL"
                ])
    ]
)
