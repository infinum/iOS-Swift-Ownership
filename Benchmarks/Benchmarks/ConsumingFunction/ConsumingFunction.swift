import Benchmark
import Foundation
import SwiftOwnership

let object = ConsumingFunc()

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
    Benchmark("With consuming") { benchmark in
        for _ in benchmark.scaledIterations {
            blackHole(object.assignTest(consumingTest: Test()))
        }
    }
    Benchmark("Without consuming") { benchmark in
        for _ in benchmark.scaledIterations {
            blackHole(object.assignTest(test: Test()))
        }
    }
}
