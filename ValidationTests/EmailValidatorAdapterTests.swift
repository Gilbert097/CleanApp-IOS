//
//  ValidationTests.swift
//  ValidationTests
//
//  Created by Gilberto Silva on 13/03/23.
//

import XCTest
import Presentation

class EmailValidatorAdapter: EmailValidator {
    private let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    public func isValid(email: String) -> Bool {
        let range = NSRange(location: 0, length: email.utf16.count)
        let regex = try! NSRegularExpression(pattern: pattern)
        return regex.firstMatch(in: email, range: range) != nil
    }
}

final class EmailValidatorAdapterTests: XCTestCase {

    func test_invalid_emails() throws {
        let sut = makeSut()
        XCTAssertFalse(sut.isValid(email: "rr"))
        XCTAssertFalse(sut.isValid(email: "rr@"))
        XCTAssertFalse(sut.isValid(email: "rr@rr"))
        XCTAssertFalse(sut.isValid(email: "rr@rr."))
        XCTAssertFalse(sut.isValid(email: "@rr."))
    }
    
    func test_valid_emails() throws {
        let sut = makeSut()
        XCTAssertTrue(sut.isValid(email: "rodrigo@gmail.com"))
        XCTAssertTrue(sut.isValid(email: "rodrigo@hotmail.com"))
        XCTAssertTrue(sut.isValid(email: "rodrigo@hotmail.com.br"))
    }
}

extension EmailValidatorAdapterTests {
    
    private func makeSut() -> EmailValidatorAdapter {
        .init()
    }
}
