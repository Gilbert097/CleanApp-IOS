//
//  CompareFieldValidationTests.swift
//  ValidationTests
//
//  Created by Gilberto Silva on 29/03/23.
//

import Foundation
import XCTest
import Presentation
import Validation

class CompareFieldValidationTests: XCTestCase {
    
    func test_validate_should_return_error_if_comparation_fails() {
        let sut = makeSut(fieldName: "password", fieldNameToCompare: "passwordConfirmation", fieldLabel: "Senha")
        let errorMessage = sut.validate(data: ["password": "123", "passwordConfirmation": "1234"])
        XCTAssertEqual(errorMessage, "O campo Senha é inválido")
    }
    
    func test_validate_should_return_error_if_with_correct_field_label() {
        let sut = makeSut(fieldName: "password", fieldNameToCompare: "passwordConfirmation", fieldLabel: "Confirmar Senha")
        let errorMessage = sut.validate(data: ["password": "123", "passwordConfirmation": "1234"])
        XCTAssertEqual(errorMessage, "O campo Confirmar Senha é inválido")
    }
    
    func test_validate_should_return_nil_if_field_comparation_succeeds() {
        let sut = makeSut(fieldName: "password", fieldNameToCompare: "passwordConfirmation", fieldLabel: "Senha")
        let errorMessage = sut.validate(data:  ["password": "123", "passwordConfirmation": "123"])
        XCTAssertNil(errorMessage)
    }
    
    func test_validate_should_return_nil_if_no_data_is_provided() {
        let sut = makeSut(fieldName: "password", fieldNameToCompare: "passwordConfirmation", fieldLabel: "Senha")
        let errorMessage = sut.validate(data: nil)
        XCTAssertEqual(errorMessage, "O campo Senha é inválido")
    }
}

extension CompareFieldValidationTests {
    func makeSut(
        fieldName: String,
        fieldNameToCompare: String,
        fieldLabel: String,
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> Validation {
        let sut = CompareFieldValidation(
            fieldName: fieldName,
            fieldNameToCompare: fieldNameToCompare,
            fieldLabel: fieldLabel
        )
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}
