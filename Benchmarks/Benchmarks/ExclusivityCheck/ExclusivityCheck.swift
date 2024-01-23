import Benchmark
import Foundation
import SwiftOwnership

let test = ExclusivityCheck()

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
    Benchmark("With exclusivity checking") { benchmark in
        for _ in benchmark.scaledIterations {
            blackHole(test.checked)
        }
    }
    Benchmark("Without exclusivity checking") { benchmark in
        for _ in benchmark.scaledIterations {
            blackHole(test.unchecked)
        }
    }
}
