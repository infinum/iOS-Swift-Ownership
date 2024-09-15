// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftOwnership",
    platforms: [.macOS(.v13)],
    products: [
        .library(
            name: "SwiftOwnership",
            targets: ["SwiftOwnership"]),
    ],
    dependencies: [
        .package(url: "https://github.com/ordo-one/package-benchmark", .upToNextMajor(from: "1.0.0"))
    ],
    targets: [
        .target(
            name: "SwiftOwnership",
            swiftSettings: [
                .unsafeFlags(["-disable-availability-checking"]),
                .enableExperimentalFeature("StaticExclusiveOnly"),
                .enableExperimentalFeature("RawLayout")
            ]
        ),
        .testTarget(
            name: "SwiftOwnershipTests",
            dependencies: ["SwiftOwnership"]),
        .executableTarget(
            name: "Retain",
            dependencies: [
                .product(name: "Benchmark", package: "package-benchmark"),
                "SwiftOwnership"
            ],
            path: "Benchmarks/Benchmarks/Retain",
            plugins: [
                .plugin(name: "BenchmarkPlugin", package: "package-benchmark")
            ]
        ),
        .executableTarget(
            name: "Copy",
            dependencies: [
                .product(name: "Benchmark", package: "package-benchmark"),
                "SwiftOwnership"
            ],
            path: "Benchmarks/Benchmarks/Copy",
            plugins: [
                .plugin(name: "BenchmarkPlugin", package: "package-benchmark")
            ]
        ),
        .executableTarget(
            name: "BorrowingInit",
            dependencies: [
                .product(name: "Benchmark", package: "package-benchmark"),
                "SwiftOwnership"
            ],
            path: "Benchmarks/Benchmarks/BorrowingInit",
            plugins: [
                .plugin(name: "BenchmarkPlugin", package: "package-benchmark")
            ]
        ),
        .executableTarget(
            name: "ConsumingFunction",
            dependencies: [
                .product(name: "Benchmark", package: "package-benchmark"),
                "SwiftOwnership"
            ],
            path: "Benchmarks/Benchmarks/ConsumingFunction",
            plugins: [
                .plugin(name: "BenchmarkPlugin", package: "package-benchmark")
            ]
        ),
        .executableTarget(
            name: "ConsumeOperator",
            dependencies: [
                .product(name: "Benchmark", package: "package-benchmark"),
                "SwiftOwnership"
            ],
            path: "Benchmarks/Benchmarks/ConsumeOperator",
            plugins: [
                .plugin(name: "BenchmarkPlugin", package: "package-benchmark")
            ]
        ),
        .executableTarget(
            name: "ExclusivityCheck",
            dependencies: [
                .product(name: "Benchmark", package: "package-benchmark"),
                "SwiftOwnership"
            ],
            path: "Benchmarks/Benchmarks/ExclusivityCheck",
            plugins: [
                .plugin(name: "BenchmarkPlugin", package: "package-benchmark")
            ]
        ),
        .executableTarget(
            name: "NonCopyable",
            dependencies: [
                .product(name: "Benchmark", package: "package-benchmark"),
                "SwiftOwnership"
            ],
            path: "Benchmarks/Benchmarks/NonCopyable",
            swiftSettings: [.unsafeFlags(["-disable-availability-checking"])],
            plugins: [
                .plugin(name: "BenchmarkPlugin", package: "package-benchmark")
            ]
        ),
        .executableTarget(
            name: "FindLongest",
            dependencies: [
                "SwiftOwnership"
            ],
            path: "Benchmarks/Benchmarks/FindLongest",
            swiftSettings: [.unsafeFlags(["-disable-availability-checking"])]
        )
    ]
)
