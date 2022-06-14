//
//  XCTestCase+Extension.swift
//  DataTests
//
//  Created by Gilberto Silva on 13/06/22.
//

import Foundation
import XCTest

public extension XCTestCase {
    
    func checkMemoryLeak(
        for instance: AnyObject,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, file: file, line: line)
        }
    }
}
