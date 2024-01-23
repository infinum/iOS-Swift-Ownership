import Benchmark
import Foundation
import SwiftOwnership

let tuple = (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)

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
    Benchmark("With copy") { benchmark in
        for _ in benchmark.scaledIterations {
            var other = (tuple, tuple, tuple, tuple)
            blackHole(other)
        }
    }
    Benchmark("Without copy") { benchmark in
        for _ in benchmark.scaledIterations {
            blackHole(tuple)
        }
    }
}
