final class X {}

let x = X()

public func doSomethingWithoutRetain() {
    return
}

public func doSomethingWithRetain() {
    let retained = Unmanaged<X>.passRetained(x)
    return
}
