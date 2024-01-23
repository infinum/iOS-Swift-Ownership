public class ConsumeOperator {
    private let first: Int

    public init(test: consuming Test) {
        first = test.x
    }
}
