//
//  ValidationCompositeTests.swift
//  ValidationTests
//
//  Created by Gilberto Silva on 30/03/23.
//

import Foundation
import XCTest
import Presentation
import Validation

class ValidationCompositeTests: XCTestCase {
    
    func test_validate_should_return_error_if_validation_fails() {
        let validationSpy = ValidationSpy()
        let sut = makeSut(validations: [validationSpy])
        validationSpy.simulateError(errorMessage: "Erro 1")
        let errorMessage = sut.validate(data: ["name": "Gilberto"])
        XCTAssertEqual(errorMessage, "Erro 1")
    }
    
    func test_validate_should_return_correct_error_message() {
        let validationSpy2 = ValidationSpy()
        let sut = makeSut(validations: [ValidationSpy(), validationSpy2])
        validationSpy2.simulateError(errorMessage: "Erro 2")
        let errorMessage = sut.validate(data: ["name": "Gilberto"])
        XCTAssertEqual(errorMessage, "Erro 2")
    }
    
    func test_validate_should_return_the_first_error_message() {
        let validationSpy2 = ValidationSpy()
        let validationSpy3 = ValidationSpy()
        let sut = makeSut(validations: [ValidationSpy(), validationSpy2, validationSpy3])
        validationSpy2.simulateError(errorMessage: "Erro 2")
        validationSpy3.simulateError(errorMessage: "Erro 3")
        let errorMessage = sut.validate(data: ["name": "Gilberto"])
        XCTAssertEqual(errorMessage, "Erro 2")
    }
    
    func test_validate_should_return_nil_if_validation_succeds() {
        let sut = makeSut(validations: [ValidationSpy(), ValidationSpy()])
        let errorMessage = sut.validate(data: ["name": "Gilberto"])
        XCTAssertNil(errorMessage)
    }
    
    func test_validate_should_call_validation_with_correct_data() {
        let validationSpy = ValidationSpy()
        let sut = makeSut(validations: [validationSpy])
        let data = ["name": "Gilberto"]
        _  = sut.validate(data: data)
        XCTAssertTrue(NSDictionary(dictionary: validationSpy.data!).isEqual(to: data))
    }
}

extension ValidationCompositeTests {
    func makeSut(
        validations: [Validation],
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> Validation {
        let sut = ValidationComposite(validations: validations)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}
