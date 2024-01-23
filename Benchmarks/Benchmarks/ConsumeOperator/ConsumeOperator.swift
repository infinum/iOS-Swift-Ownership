import Benchmark
import Foundation
import SwiftOwnership

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
    Benchmark("With consume") { benchmark in
        for _ in benchmark.scaledIterations {
            var test = Test()
            blackHole(ConsumeOperator(test: consume test))
            // let new = test // NOT ALLOWED
        }
    }
    Benchmark("Without consume") { benchmark in
        for _ in benchmark.scaledIterations {
            var test = Test()
            blackHole(ConsumeOperator(test: test))
            // let new = test // ALLOWED
        }
    }
}
