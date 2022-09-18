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
        result.sut.signUp(viewModel: makeSignUpViewModel(name: nil))
        XCTAssertEqual(result.alertViewSpy.viewModel, makeRequiredAlertViewModel(fieldName: "Nome"))
    }
    
    func test_signUp_should_show_error_message_if_email_is_not_provided() throws {
        let result = makeSut()
        result.sut.signUp(viewModel: makeSignUpViewModel(email: nil))
        XCTAssertEqual(result.alertViewSpy.viewModel, makeRequiredAlertViewModel(fieldName: "Email"))
    }
    
    func test_signUp_should_show_error_message_if_password_is_not_provided() throws {
        let result = makeSut()
        result.sut.signUp(viewModel: makeSignUpViewModel(password: nil))
        XCTAssertEqual(result.alertViewSpy.viewModel, makeRequiredAlertViewModel(fieldName: "Senha"))
    }
    
    func test_signUp_should_show_error_message_if_password_confirmation_is_not_provided() throws {
        let result = makeSut()
        result.sut.signUp(viewModel: makeSignUpViewModel(passwordConfirmation: nil))
        XCTAssertEqual(result.alertViewSpy.viewModel, makeRequiredAlertViewModel(fieldName: "Confirmar Senha"))
    }
    
    func test_signUp_should_show_error_message_if_password_confirmation_not_match() throws {
        let result = makeSut()
        result.sut.signUp(viewModel: makeSignUpViewModel(passwordConfirmation: "wrong_password"))
        XCTAssertEqual(result.alertViewSpy.viewModel, makeInvalidAlertViewModel(fieldName: "Confirmar Senha"))
    }
    
    func test_signUp_should_show_error_message_if_invalid_email_is_provided() throws {
        let result = makeSut()
        result.emailValidatorSpy.simulateInvalidEmail()
        result.sut.signUp(viewModel: makeSignUpViewModel())
        XCTAssertEqual(result.alertViewSpy.viewModel, makeInvalidAlertViewModel(fieldName: "Email"))
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
    
    func test_signUp_should_show_error_message_if_iaddAccount_fails() throws {
        let result = makeSut()
        result.sut.signUp(viewModel: makeSignUpViewModel())
        result.addAccountSpy.completeWithError(.unexpected)
        XCTAssertEqual(result.alertViewSpy.viewModel, makeErrorAlertViewModel(message: "Algo inesperado aconteceu, tente novamente em alguns instantes."))
    }
}

extension SignUpPresenterTests {
    
    typealias SUT = (sut: SignUpPresenter,
                     alertViewSpy: AlertViewSpy,
                     emailValidatorSpy: EmailValidatorSpy,
                     addAccountSpy: AddAccountSpy)
    
    func makeSut() -> SUT {
        let alertViewSpy = AlertViewSpy()
        let emailValidatorSpy = EmailValidatorSpy()
        let addAccountSpy = AddAccountSpy()
        let sut = SignUpPresenter(alertView: alertViewSpy,
                                  emailValidator: emailValidatorSpy,
                                  addAccount: addAccountSpy)
        return (sut, alertViewSpy, emailValidatorSpy, addAccountSpy)
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
        var viewModel: AlertViewModel?
        
        func showMessage(viewModel: AlertViewModel) {
            self.viewModel = viewModel
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
