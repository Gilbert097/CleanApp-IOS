//
//  ValidationTests.swift
//  ValidationTests
//
//  Created by Gilberto Silva on 13/03/23.
//

import XCTest
import Infra
import Validation

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
