public final class BorrowingInit {
    private let first: Int

    public init(test: Test) {
        first = test.x
    }

    public init(consumingTest: consuming Test) {
        first = consumingTest.x
    }

    public init(borrowingTest: borrowing Test) {
        first = borrowingTest.x
    }
}
