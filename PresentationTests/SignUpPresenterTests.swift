//
//  PresentationTests.swift
//  PresentationTests
//
//  Created by Gilberto Silva on 12/09/22.
//

import XCTest

class SignUpPresenter {
    let alertView: AlertView
    
    init(alertView: AlertView) {
        self.alertView = alertView
    }
    
    func signUp(viewModel: SignUpViewModel){
        if viewModel.name == nil || viewModel.name!.isEmpty {
            self.alertView.showMessage(viewModel: AlertViewModel(title: "Falha na validação", message: "O campo Nome é obrigatório"))
        }
    }
}

protocol AlertView {
    func showMessage(viewModel: AlertViewModel)
}

struct SignUpViewModel{
    var name: String?
    var email: String?
    var password: String?
    var passwordConfirmation: String?
}

struct AlertViewModel: Equatable {
    var title: String
    var message: String
}

class SignUpPresenterTests: XCTestCase {
    
    func test_signUp_should_show_error_message_if_name_is_not_provided() throws {
        let (sut, alertViewSpy) = makeSut()
        let signUpViewModel = SignUpViewModel(email: "any_email@mail.com", password: "any_password", passwordConfirmation: "any_password")
        sut.signUp(viewModel: signUpViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na validação", message: "O campo Nome é obrigatório"))
    }
}

extension SignUpPresenterTests {
    
    func makeSut() -> (sut: SignUpPresenter, alertView: AlertViewSpy) {
        let alertViewSpy = AlertViewSpy()
        let sut = SignUpPresenter(alertView: alertViewSpy)
        return (sut, alertViewSpy)
    }
   
    class AlertViewSpy: AlertView {
        var viewModel: AlertViewModel?
        
        func showMessage(viewModel: AlertViewModel) {
            self.viewModel = viewModel
        }
    }
}
