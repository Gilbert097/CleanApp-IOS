//
//  LoginControllerFactoryTests.swift
//  MainTests
//
//  Created by Gilberto Silva on 03/04/23.
//

import XCTest
import Main
import UI
import Validation

final class LoginControllerFactoryTests: XCTestCase {
    
    func test_background_request_should_complete_on_main_thread() throws {
        let (sut, addAccountSpy) = makeSut()
        sut.loadViewIfNeeded()
        sut.login?(makeLoginViewModel())
        let exp = expectation(description: "waiting")
        DispatchQueue.global().async {
            addAccountSpy.completeWithError(.unexpected)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }
    
    func test_login_compose_with_correct_validations() {
        let validations = makeLoginValidations()
        XCTAssertEqual(validations[0] as! RequiredFieldValidation, RequiredFieldValidation(fieldName: "email", fieldLabel: "Email"))
        XCTAssertEqual(validations[1] as! EmailValidation, EmailValidation(fieldName: "email", fieldLabel: "Email", emailValidator: EmailValidatorSpy()))
        XCTAssertEqual(validations[2] as! RequiredFieldValidation, RequiredFieldValidation(fieldName: "password", fieldLabel: "Senha"))
    }
}

extension LoginControllerFactoryTests{
    
    func makeSut(file: StaticString = #filePath, line: UInt = #line) -> (sut: LoginViewController, authenticationSpy: AuthenticationSpy) {
        let authenticationSpy = AuthenticationSpy()
        let sut = makeLoginController(authentication: MainQueueDispatchDecorator(authenticationSpy))
        checkMemoryLeak(for: sut, file: file, line: line)
        checkMemoryLeak(for: authenticationSpy, file: file, line: line)
        return (sut, authenticationSpy)
    }
}
