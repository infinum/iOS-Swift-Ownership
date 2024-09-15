import Foundation

public final class FileChunkC {
    private let maxCount: Int
    let _buffer: UnsafeMutablePointer<CChar>

    init(maxCount: Int) {
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

extension File {
    public func readLine(reuseChunk: FileChunkC?) throws -> FileChunkC? {
        let chunk = reuseChunk ?? FileChunkC(maxCount: maxLength)
        if fgets(chunk._buffer, Int32(maxLength), file) == nil {
            if feof(file) != 0 {
                return nil
            } else {
                throw NSError(domain: NSPOSIXErrorDomain, code: Int(errno), userInfo: nil)
            }
        }
        return chunk
    }

    public func findLongestNoArrayFtell(reuse: Bool) throws -> String? {
        var longest: FileChunkC? = nil
        var toReuse = reuse ? FileChunkC(maxCount: maxLength) : nil
        var position: Int = 0
        var longestCount: Int = 0
        while let line: FileChunkC = try readLine(reuseChunk: toReuse) {
            let newPosition = ftell(file)
            let count = newPosition - position
            position = newPosition
            if count > longestCount {
                if let longest {
                    toReuse = longest
                }
                longest = line
                longestCount = count
            } else {
                toReuse = line
            }
        }
        return longest?.asString
    }

    public func findLongestNoArray(reuse: Bool) throws -> String? {
        var longest: FileChunkC? = nil
        var toReuse = reuse ? FileChunkC(maxCount: maxLength) : nil
        var longestCount: Int = 0
        while let line: FileChunkC = try readLine(reuseChunk: toReuse) {
            let count = line.count
            if count > longestCount {
                if let longest {
                    toReuse = longest
                }
                longest = line
                longestCount = count
            } else {
                toReuse = line
            }
        }
        return longest?.asString
    }
}
