public final class ConsumingFunc {
    private var test: Test!

    public init() {

    }

    public func assignTest(consumingTest: consuming Test) {
        self.test = consumingTest
    }

    public func assignTest(test: Test) {
        self.test = test
    }
}
