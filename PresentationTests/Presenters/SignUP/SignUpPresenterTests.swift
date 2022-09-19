//
//  PresentationTests.swift
//  PresentationTests
//
//  Created by Gilberto Silva on 12/09/22.
//

import XCTest
import Presentation
import Domain

class SignUpPresenterTests: XCTestCase {
    
    func test_signUp_should_show_error_message_if_name_is_not_provided() throws {
        let result = makeSut()
        let exp = expectation(description: "waiting")
        result.alertViewSpy.observe { viewModel in
            exp.fulfill()
            XCTAssertEqual(viewModel, makeRequiredAlertViewModel(fieldName: "Nome"))
        }
        result.sut.signUp(viewModel: makeSignUpViewModel(name: nil))
        wait(for: [exp], timeout: 0.1)
    }
    
    func test_signUp_should_show_error_message_if_email_is_not_provided() throws {
        let result = makeSut()
        let exp = expectation(description: "waiting")
        result.alertViewSpy.observe { viewModel in
            exp.fulfill()
            XCTAssertEqual(viewModel, makeRequiredAlertViewModel(fieldName: "Email"))
        }
        result.sut.signUp(viewModel: makeSignUpViewModel(email: nil))
        wait(for: [exp], timeout: 0.1)
    }
    
    func test_signUp_should_show_error_message_if_password_is_not_provided() throws {
        let result = makeSut()
        let exp = expectation(description: "waiting")
        result.alertViewSpy.observe { viewModel in
            exp.fulfill()
            XCTAssertEqual(viewModel, makeRequiredAlertViewModel(fieldName: "Senha"))
        }
        result.sut.signUp(viewModel: makeSignUpViewModel(password: nil))
        wait(for: [exp], timeout: 0.1)
    }
    
    func test_signUp_should_show_error_message_if_password_confirmation_is_not_provided() throws {
        let result = makeSut()
        let exp = expectation(description: "waiting")
        result.alertViewSpy.observe { viewModel in
            exp.fulfill()
            XCTAssertEqual(viewModel, makeRequiredAlertViewModel(fieldName: "Confirmar Senha"))
        }
        result.sut.signUp(viewModel: makeSignUpViewModel(passwordConfirmation: nil))
        wait(for: [exp], timeout: 0.1)
    }
    
    func test_signUp_should_show_error_message_if_password_confirmation_not_match() throws {
        let result = makeSut()
        let exp = expectation(description: "waiting")
        result.alertViewSpy.observe { viewModel in
            exp.fulfill()
            XCTAssertEqual(viewModel, makeInvalidAlertViewModel(fieldName: "Confirmar Senha"))
        }
        result.sut.signUp(viewModel: makeSignUpViewModel(passwordConfirmation: "wrong_password"))
        wait(for: [exp], timeout: 0.1)
    }
    
    func test_signUp_should_show_error_message_if_invalid_email_is_provided() throws {
        let result = makeSut()
        result.emailValidatorSpy.simulateInvalidEmail()
        let exp = expectation(description: "waiting")
        result.alertViewSpy.observe { viewModel in
            exp.fulfill()
            XCTAssertEqual(viewModel, makeInvalidAlertViewModel(fieldName: "Email"))
        }
        result.sut.signUp(viewModel: makeSignUpViewModel())
        wait(for: [exp], timeout: 0.1)
    }
    
    func test_signUp_should_call_emailValidator_with_correct_email() throws {
        let result = makeSut()
        let signUpViewModel = makeSignUpViewModel()
        result.sut.signUp(viewModel: signUpViewModel)
        XCTAssertEqual(result.emailValidatorSpy.email, signUpViewModel.email)
    }
    
    func test_signUp_should_call_addAccount_with_correct_values() throws {
        let result = makeSut()
        result.sut.signUp(viewModel: makeSignUpViewModel())
        XCTAssertEqual(result.addAccountSpy.addAccountModel, makeAddAccountModel())
    }
    
    func test_signUp_should_show_error_message_if_addAccount_fails() throws {
        let result = makeSut()
        let exp = expectation(description: "waiting")
        result.alertViewSpy.observe { viewModel in
            exp.fulfill()
            XCTAssertEqual(viewModel, makeErrorAlertViewModel(message: "Algo inesperado aconteceu, tente novamente em alguns instantes."))
        }
        result.sut.signUp(viewModel: makeSignUpViewModel())
        result.addAccountSpy.completeWithError(.unexpected)
        wait(for: [exp], timeout: 0.1)
    }
    
    func test_signUp_should_show_loading_before_call_addAcount() throws {
        let result = makeSut()
        let exp = expectation(description: "waiting")
        result.loadingView.observe { viewModel in
            exp.fulfill()
          XCTAssertEqual(viewModel.isLoading, true)
        }
        result.sut.signUp(viewModel: makeSignUpViewModel())
        wait(for: [exp], timeout: 0.1)
    }
    
    func test_signUp_should_show_loading_before_and_after_addAcount() throws {
        let result = makeSut()
        let expBefore = expectation(description: "waitingBefore")
        result.loadingView.observe { viewModel in
            expBefore.fulfill()
          XCTAssertEqual(viewModel.isLoading, true)
        }
        result.sut.signUp(viewModel: makeSignUpViewModel())
        wait(for: [expBefore], timeout: 0.1)
        
        let expAfter = expectation(description: "waitingAfter")
        result.loadingView.observe { viewModel in
            expAfter.fulfill()
          XCTAssertEqual(viewModel.isLoading, false)
        }
        result.addAccountSpy.completeWithError(.unexpected)
        wait(for: [expAfter], timeout: 0.1)
    }
    
    func test_signUp_should_show_success_message_if_addAccount_succeeds() throws {
        let result = makeSut()
        let exp = expectation(description: "waiting")
        result.alertViewSpy.observe { viewModel in
            exp.fulfill()
            XCTAssertEqual(viewModel, makeSuccessAlertViewModel(message: "Conta criada com successo."))
        }
        result.sut.signUp(viewModel: makeSignUpViewModel())
        result.addAccountSpy.completeWithAccount(makeAccountModel())
        wait(for: [exp], timeout: 0.1)
    }
}

extension SignUpPresenterTests {
    
    typealias SUT = (sut: SignUpPresenter,
                     alertViewSpy: AlertViewSpy,
                     emailValidatorSpy: EmailValidatorSpy,
                     addAccountSpy: AddAccountSpy,
                     loadingView: LoagingViewSpy)
    
    func makeSut(file: StaticString = #filePath, line: UInt = #line) -> SUT {
        let alertViewSpy = AlertViewSpy()
        let emailValidatorSpy = EmailValidatorSpy()
        let addAccountSpy = AddAccountSpy()
        let loadingViewSpy = LoagingViewSpy()
        let sut = SignUpPresenter(alertView: alertViewSpy,
                                  emailValidator: emailValidatorSpy,
                                  addAccount: addAccountSpy,
                                  loadingView: loadingViewSpy)
        checkMemoryLeak(for: sut, file: file, line: line)
        return (sut, alertViewSpy, emailValidatorSpy, addAccountSpy, loadingViewSpy)
    }
    
}
