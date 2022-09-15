//
//  PresentationTests.swift
//  PresentationTests
//
//  Created by Gilberto Silva on 12/09/22.
//

import XCTest
import Presentation

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
    
    func test_signUp_should_call_emailValidator_with_correct_email() throws {
        let result = makeSut()
        let signUpViewModel = makeSignUpViewModel()
        result.sut.signUp(viewModel: signUpViewModel)
        XCTAssertEqual(result.emailValidatorSpy.email, signUpViewModel.email)
    }
    
    func test_signUp_should_show_error_message_if_invalid_email_is_provided() throws {
        let result = makeSut()
        result.emailValidatorSpy.simulateInvalidEmail()
        result.sut.signUp(viewModel: makeSignUpViewModel())
        XCTAssertEqual(result.alertViewSpy.viewModel, makeInvalidAlertViewModel(fieldName: "Email"))
    }
}

extension SignUpPresenterTests {
    
    typealias SUT = (sut: SignUpPresenter, alertViewSpy: AlertViewSpy, emailValidatorSpy: EmailValidatorSpy)
    
    func makeSut() -> SUT {
        let alertViewSpy = AlertViewSpy()
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = SignUpPresenter(alertView: alertViewSpy, emailValidator: emailValidatorSpy)
        return (sut, alertViewSpy, emailValidatorSpy)
    }
    
    func makeSignUpViewModel(
        name: String? = "any_name",
        email: String? = "invalid_email@mail.com",
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
    
}
