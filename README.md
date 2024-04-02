# Swift Ownership

Associated source code for Swift Ownership blog post. Blog post is available [here](https://infinum.com/blog/swift-ownership/).

## Various performance benchmarks from the blog post

- Performance impact of dynamic exclusivity checking:

![Borrow](./Resources/dynamic-checking.webp)

- Performance impact of `retain`:

![Retain](./Resources/retain.webp)

- Performance impact of copying big `struct`:

![Copy](./Resources/copy.webp)

- Impact of using `borrowing` keyword in `init` when ownership is not required

![Borrow](./Resources/borrowing-init.webp)

- Impact of using `consuming` keywoard in a function that requires ownership:

![Consuming](./Resources/consuming-function.webp)

- Impact of using `consume` operator when transferring ownership:

![Consume](./Resources/consume-operator.webp)
