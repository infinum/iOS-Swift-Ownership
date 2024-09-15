import Foundation

public extension File {
    func findLongestNonCopyableFtell(reuse: Bool) throws -> String? {
        var longest: FileChunk? = nil
        var toReuse: FileChunk? = nil
        var position: Int = 0
        var longestCount: Int = 0
        while let line: FileChunk = try readLine(toReuse: reuse ? toReuse : nil) {
            let newPosition = ftell(file)
            let count = newPosition - position
            position = newPosition
            if count > longestCount {
                toReuse = longest
                longest = consume line
                longestCount = count
            } else {
                toReuse = consume line
            }
        }
        return longest?.asString
    }

    func findLongestNonCopyable() throws -> String? {
        var longest: FileChunk? = nil
        var buffer: FileChunk? = FileChunk(maxCount: maxLength)
        var longestCount: Int = 0
        while let line: FileChunk = try readLine(toReuse: buffer) {
            let count = line.count
            if count > longestCount {
                buffer = longest
                longest = consume line
                longestCount = count
            } else {
                buffer = consume line
            }
        }
        return longest?.asString
    }
}

public struct FileChunk: ~Copyable {
    private let maxCount: Int
    let _buffer: UnsafeMutablePointer<CChar>

    public init(maxCount: Int) {
        precondition(maxCount > 0)
        self.maxCount = maxCount
        _buffer = UnsafeMutablePointer<CChar>.allocate(capacity: maxCount)
        _buffer.initialize(repeating: 0, count: maxCount)
    }

    deinit {
        _buffer.deinitialize(count: maxCount)
        _buffer.deallocate()
    }

    public var count: Int {
        strlen(_buffer)
    }

    public var asString: String {
        String(cString: _buffer)
    }
}

private extension File {
    func readLine(toReuse: consuming FileChunk? = nil) throws -> FileChunk? {
        let currentChunk = toReuse ?? FileChunk(maxCount: maxLength)
        if fgets(currentChunk._buffer, Int32(maxLength), file) == nil {
            if feof(file) != 0 {
                return nil
            } else {
                throw NSError(domain: NSPOSIXErrorDomain, code: Int(errno), userInfo: nil)
            }
        }
        return currentChunk
    }
}
