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
    
    func test_signUp_should_show_error_message_if_validation_fails() throws {
        let alertViewSpy = AlertViewSpy()
        let validationSpy = ValidationSpy()
        let sut = makeSut(alertViewSpy: alertViewSpy, validationSpy: validationSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { viewModel in
            exp.fulfill()
            XCTAssertEqual(viewModel, AlertViewModel(title: "Falha na validação", message: "Erro"))
        }
        validationSpy.simulateError()
        sut.login(viewModel: makeLoginViewModel())
        wait(for: [exp], timeout: 0.1)
    }
    
    func test_login_should_call_authentication_with_correct_values() {
        let authenticationSpy = AuthenticationSpy()
        let sut = makeSut(authenticationSpy: authenticationSpy)
        let viewModel = makeLoginViewModel()
        sut.login(viewModel: viewModel)
        XCTAssertEqual(authenticationSpy.authenticationModel, makeAuthenticationModel())
    }
    
    func test_login_should_show_generic_error_message_if_athentication_fails() throws {
        let alertViewSpy = AlertViewSpy()
        let authenticationSpy = AuthenticationSpy()
        let sut = makeSut(alertViewSpy: alertViewSpy, authenticationSpy: authenticationSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { viewModel in
            exp.fulfill()
            XCTAssertEqual(viewModel, AlertViewModel(title: "Erro", message: "Algo inesperado aconteceu, tente novamente em alguns instantes."))
        }
        sut.login(viewModel: makeLoginViewModel())
        authenticationSpy.completeWithError(.unexpected)
        wait(for: [exp], timeout: 0.1)
    }
    
    func test_login_should_show_expired_session_error_message_if_authentication_completes_expired_session_error() throws {
        let alertViewSpy = AlertViewSpy()
        let authenticationSpy = AuthenticationSpy()
        let sut = makeSut(alertViewSpy: alertViewSpy, authenticationSpy: authenticationSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { viewModel in
            exp.fulfill()
            XCTAssertEqual(viewModel, AlertViewModel(title: "Erro", message: "Email e/ou senha inválidos."))
        }
        sut.login(viewModel: makeLoginViewModel())
        authenticationSpy.completeWithError(.expiredSession)
        wait(for: [exp], timeout: 0.1)
    }
    
    func test_login_should_show_success_message_if_authentication_succeeds() throws {
        let alertViewSpy = AlertViewSpy()
        let authenticationSpy = AuthenticationSpy()
        let sut = makeSut(alertViewSpy: alertViewSpy, authenticationSpy: authenticationSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { viewModel in
            exp.fulfill()
            XCTAssertEqual(viewModel, AlertViewModel(title: "Sucesso", message: "Login feito com successo."))
        }
        sut.login(viewModel: makeLoginViewModel())
        authenticationSpy.completeWithAccount(makeAccountModel())
        wait(for: [exp], timeout: 0.1)
    }
}

extension LoginPresenterTests {
    
    func makeSut(
        alertViewSpy: AlertViewSpy = .init(),
        authenticationSpy: AuthenticationSpy = .init(),
        validationSpy: ValidationSpy = .init(),
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> LoginPresenter {
        let sut = LoginPresenter(alertView: alertViewSpy,
                                 authentication: authenticationSpy,
                                 validation: validationSpy)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}
