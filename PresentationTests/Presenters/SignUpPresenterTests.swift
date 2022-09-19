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
        result.alertViewSpy.observe { [weak self] viewModel in
            exp.fulfill()
            XCTAssertEqual(viewModel, self?.makeRequiredAlertViewModel(fieldName: "Nome"))
        }
        result.sut.signUp(viewModel: makeSignUpViewModel(name: nil))
        wait(for: [exp], timeout: 0.1)
    }
    
    func test_signUp_should_show_error_message_if_email_is_not_provided() throws {
        let result = makeSut()
        let exp = expectation(description: "waiting")
        result.alertViewSpy.observe { [weak self] viewModel in
            exp.fulfill()
            XCTAssertEqual(viewModel, self?.makeRequiredAlertViewModel(fieldName: "Email"))
        }
        result.sut.signUp(viewModel: makeSignUpViewModel(email: nil))
        wait(for: [exp], timeout: 0.1)
    }
    
    func test_signUp_should_show_error_message_if_password_is_not_provided() throws {
        let result = makeSut()
        let exp = expectation(description: "waiting")
        result.alertViewSpy.observe { [weak self] viewModel in
            exp.fulfill()
            XCTAssertEqual(viewModel, self?.makeRequiredAlertViewModel(fieldName: "Senha"))
        }
        result.sut.signUp(viewModel: makeSignUpViewModel(password: nil))
        wait(for: [exp], timeout: 0.1)
    }
    
    func test_signUp_should_show_error_message_if_password_confirmation_is_not_provided() throws {
        let result = makeSut()
        let exp = expectation(description: "waiting")
        result.alertViewSpy.observe { [weak self] viewModel in
            exp.fulfill()
            XCTAssertEqual(viewModel, self?.makeRequiredAlertViewModel(fieldName: "Confirmar Senha"))
        }
        result.sut.signUp(viewModel: makeSignUpViewModel(passwordConfirmation: nil))
        wait(for: [exp], timeout: 0.1)
    }
    
    func test_signUp_should_show_error_message_if_password_confirmation_not_match() throws {
        let result = makeSut()
        let exp = expectation(description: "waiting")
        result.alertViewSpy.observe { [weak self] viewModel in
            exp.fulfill()
            XCTAssertEqual(viewModel, self?.makeInvalidAlertViewModel(fieldName: "Confirmar Senha"))
        }
        result.sut.signUp(viewModel: makeSignUpViewModel(passwordConfirmation: "wrong_password"))
        wait(for: [exp], timeout: 0.1)
    }
    
    func test_signUp_should_show_error_message_if_invalid_email_is_provided() throws {
        let result = makeSut()
        result.emailValidatorSpy.simulateInvalidEmail()
        let exp = expectation(description: "waiting")
        result.alertViewSpy.observe { [weak self] viewModel in
            exp.fulfill()
            XCTAssertEqual(viewModel, self?.makeInvalidAlertViewModel(fieldName: "Email"))
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
        result.alertViewSpy.observe { [weak self] viewModel in
            exp.fulfill()
            XCTAssertEqual(viewModel, self?.makeErrorAlertViewModel(message: "Algo inesperado aconteceu, tente novamente em alguns instantes."))
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
    
    func makeSignUpViewModel(
        name: String? = "any_name",
        email: String? = "any_email@mail.com",
        password: String? =  "any_password",
        passwordConfirmation: String? = "any_password"
    ) -> SignUpViewModel {
        return SignUpViewModel(name: name, email: email, password: password, passwordConfirmation: passwordConfirmation)
    }
    
    func makeRequiredAlertViewModel(fieldName: String) -> AlertViewModel {
        return AlertViewModel(title: "Falha na validação", message: "O campo \(fieldName) é obrigatório")
    }
    
    func makeInvalidAlertViewModel(fieldName: String) -> AlertViewModel {
        return AlertViewModel(title: "Falha na validação", message: "O campo \(fieldName) é inválido")
    }
    
    func makeErrorAlertViewModel(message: String) -> AlertViewModel {
        return AlertViewModel(title: "Erro", message: message)
    }
    
    class EmailValidatorSpy: EmailValidator {
        var isvalid = true
        var email: String?
        
        func isValid(email: String) -> Bool {
            self.email = email
            return isvalid
        }
        
        func simulateInvalidEmail() {
            self.isvalid = false
        }
    }
   
    class AlertViewSpy: AlertView {
        var emit: ((AlertViewModel) -> Void)?
        
        func observe(completion: @escaping (AlertViewModel) -> Void) {
            self.emit = completion
        }
        
        func showMessage(viewModel: AlertViewModel) {
            self.emit?(viewModel)
        }
    }
    
    class LoagingViewSpy: LoagingView {
        var emit: ((LoagingViewModel) -> Void)?
        
        func observe(completion: @escaping (LoagingViewModel) -> Void) {
            self.emit = completion
        }
        
        func display(viewModel: LoagingViewModel) {
            self.emit?(viewModel)
        }
    }
    
    
    class AddAccountSpy: AddAccount {
        var addAccountModel: AddAccountModel?
        var completion: ((Result<AccountModel, DomainError>) -> Void)?
        
        func add(addAccountModel: AddAccountModel,
                 completion: @escaping (Result<AccountModel, DomainError>) -> Void) {
            self.addAccountModel = addAccountModel
            self.completion = completion
        }
        
        func completeWithError(_ error: DomainError) {
            self.completion?(.failure(error))
        }
    }
}
