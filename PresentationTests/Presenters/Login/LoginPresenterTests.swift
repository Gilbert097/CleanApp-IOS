//
//  LoginPresenterTests.swift
//  PresentationTests
//
//  Created by Gilberto Silva on 02/04/23.
//

import Foundation
import XCTest
import Presentation
import Domain

class LoginPresenterTests: XCTestCase {
    
    func test_login_should_call_validation_with_correct_values() {
        let validationSpy = ValidationSpy()
        let sut = makeSut(validationSpy: validationSpy)
        let viewModel = makeLoginViewModel()
        sut.login(viewModel: viewModel)
        XCTAssertTrue((NSDictionary(dictionary: validationSpy.data!).isEqual(to: viewModel.toJson()!)))
    }
}

extension LoginPresenterTests {
    
    func makeSut(
        validationSpy: ValidationSpy = .init(),
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> LoginPresenter {
        let sut = LoginPresenter(validation: validationSpy)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}
