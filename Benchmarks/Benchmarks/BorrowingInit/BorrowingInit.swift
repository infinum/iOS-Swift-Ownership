import Benchmark
import Foundation
import SwiftOwnership

let object = Test()

let benchmarks = {
    Benchmark.defaultConfiguration.scalingFactor = .giga
    Benchmark.defaultConfiguration.metrics = [
        .mallocCountTotal,
        .retainCount,
        .releaseCount,
        .retainReleaseDelta,
        .cpuTotal
    ]
    Benchmark.defaultConfiguration.timeUnits = .milliseconds
    Benchmark("With borrowing") { benchmark in
        for _ in benchmark.scaledIterations {
            blackHole(BorrowingInit(borrowingTest: object))
        }
    }
    Benchmark("Without borrowing") { benchmark in
        for _ in benchmark.scaledIterations {
            blackHole(BorrowingInit(test: object))
        }
    }
}
