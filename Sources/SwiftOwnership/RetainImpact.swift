final class X {
    func testMe() {

    }
}

let x = X()

public func doSomethingWithoutRetain() {
    x.testMe()
}

public func doSomethingWithRetain() {
    let retained = Unmanaged<X>.passRetained(x)
    x.testMe()
}
