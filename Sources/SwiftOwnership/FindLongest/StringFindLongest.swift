import Foundation

public extension File {
    func findLongestNaive() throws -> String? {
        var longest: String? = nil
        while let line: String = try readLine() {
            if line.count > (longest?.count ?? 0) {
                longest = line
            }
        }
        return longest
    }

    func findLongestCCharArray(reuse: Bool) throws -> String? {
        var buffer: [CChar]? = reuse ? [CChar](repeating: 0, count: maxLength) : nil
        var longest: [CChar]? = nil
        var longestCount: Int = 0
        while let line: [CChar] = try readLine(reuseChunk: &buffer) {
            let count = line.withUnsafeBufferPointer { pointer in strlen(pointer.baseAddress!) }
            if count > longestCount {
                // TODO: bug here
                longest = line
                longestCount = count
            }
        }
        return longest.map { String(cString: $0) }
    }
}

private extension File {
    func readLine() throws -> String? {
        var buffer = [CChar](repeating: 0, count: maxLength)
        if fgets(&buffer, Int32(maxLength), file) == nil {
            if feof(file) != 0 {
                return nil
            } else {
                throw NSError(domain: NSPOSIXErrorDomain, code: Int(errno), userInfo: nil)
            }
        }
        return String(cString: buffer)
    }

    func readLine(reuseChunk: inout [CChar]?) throws -> [CChar]? {
        var buffer = reuseChunk ?? [CChar](repeating: 0, count: maxLength)
        if fgets(&buffer, Int32(maxLength), file) == nil {
            if feof(file) != 0 {
                return nil
            } else {
                throw NSError(domain: NSPOSIXErrorDomain, code: Int(errno), userInfo: nil)
            }
        }
        return buffer
    }
}
