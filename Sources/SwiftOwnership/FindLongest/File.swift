//
//  File.swift
//  SwiftOwnership
//
//  Created by Josip Cavar on 15.09.2024..
//

import Foundation

let maxLength = 100000

public final class File {
    let file: UnsafeMutablePointer<FILE>

    public init(fileURL: URL) throws {
        guard let file = fopen(fileURL.path, "r") else {
            throw NSError(
                domain: NSPOSIXErrorDomain,
                code: Int(errno),
                userInfo: nil
            )
        }
        self.file = file
    }

    deinit {
        let success = fclose(file) == 0
        assert(success)
    }
}
