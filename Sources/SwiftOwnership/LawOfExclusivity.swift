var globalX = 1

func addGlobalX(y: inout Int) {
    y += globalX
}

func callAddGlobalX() {
    // ALLOWED at compile time, but fails at runtime (dynamic enforcement)
    addGlobalX(y: &globalX)
}

func addAndReset(x: inout Int, y: inout Int, count: Int) {
    var i = 0
    while i < count {
        x += y
        i += 1
    }
    y = 0
}

func callAddAndReset() {
    // NOT ALLOWED
    // addAndReset(x: &globalX, y: &globalX, count: 100)
}

