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

    func test_signUp_should_show_generic_error_message_if_addAccount_fails() throws {
        let alertViewSpy = AlertViewSpy()
        let addAccountSpy = AddAccountSpy()
        let sut = makeSut(alertViewSpy: alertViewSpy, addAccountSpy: addAccountSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { viewModel in
            exp.fulfill()
            XCTAssertEqual(viewModel, AlertViewModel(title: "Erro", message: "Algo inesperado aconteceu, tente novamente em alguns instantes."))
        }
        sut.signUp(viewModel: makeSignUpViewModel())
        addAccountSpy.completeWithError(.unexpected)
        wait(for: [exp], timeout: 0.1)
    }
    
    func test_signUp_should_show_email_in_use_error_message_if_addAccount_returns_email_in_use_error() throws {
        let alertViewSpy = AlertViewSpy()
        let addAccountSpy = AddAccountSpy()
        let sut = makeSut(alertViewSpy: alertViewSpy, addAccountSpy: addAccountSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { viewModel in
            exp.fulfill()
            XCTAssertEqual(viewModel, AlertViewModel(title: "Erro", message: "Esse e-mail já está em uso."))
        }
        sut.signUp(viewModel: makeSignUpViewModel())
        addAccountSpy.completeWithError(.emailInUse)
        wait(for: [exp], timeout: 0.1)
    }
    
    func test_signUp_should_show_loading_before_call_addAcount() throws {
        let loadingViewSpy = LoagingViewSpy()
        let sut = makeSut(loadingViewSpy: loadingViewSpy)
        let exp = expectation(description: "waiting")
        loadingViewSpy.observe { viewModel in
            exp.fulfill()
            XCTAssertEqual(viewModel.isLoading, true)
        }
        sut.signUp(viewModel: makeSignUpViewModel())
        wait(for: [exp], timeout: 0.1)
    }
    
    func test_signUp_should_show_loading_before_and_after_addAcount() throws {
        let loadingViewSpy = LoagingViewSpy()
        let addAccountSpy = AddAccountSpy()
        let sut = makeSut(addAccountSpy: addAccountSpy, loadingViewSpy: loadingViewSpy)
        let expBefore = expectation(description: "waitingBefore")
        loadingViewSpy.observe { viewModel in
            expBefore.fulfill()
            XCTAssertEqual(viewModel.isLoading, true)
        }
        sut.signUp(viewModel: makeSignUpViewModel())
        wait(for: [expBefore], timeout: 0.1)
        
        let expAfter = expectation(description: "waitingAfter")
        loadingViewSpy.observe { viewModel in
            expAfter.fulfill()
            XCTAssertEqual(viewModel.isLoading, false)
        }
        addAccountSpy.completeWithError(.unexpected)
        wait(for: [expAfter], timeout: 0.1)
    }
    
    func test_signUp_should_show_success_message_if_addAccount_succeeds() throws {
        let alertViewSpy = AlertViewSpy()
        let addAccountSpy = AddAccountSpy()
        let sut = makeSut(alertViewSpy: alertViewSpy, addAccountSpy: addAccountSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { viewModel in
            exp.fulfill()
            XCTAssertEqual(viewModel, AlertViewModel(title: "Sucesso", message: "Conta criada com successo."))
        }
        sut.signUp(viewModel: makeSignUpViewModel())
        addAccountSpy.completeWithAccount(makeAccountModel())
        wait(for: [exp], timeout: 0.1)
    }
    
    func test_signUp_should_call_validation_with_correct_value() {
        let validationSpy = ValidationSpy()
        let sut = makeSut(validationSpy: validationSpy)
        let viewModel = makeSignUpViewModel()
        sut.signUp(viewModel: viewModel)
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
        sut.signUp(viewModel: makeSignUpViewModel())
        wait(for: [exp], timeout: 0.1)
    }
}

extension SignUpPresenterTests {
    
    func makeSut(
        alertViewSpy: AlertViewSpy = .init(),
        addAccountSpy: AddAccountSpy = .init(),
        loadingViewSpy: LoagingViewSpy = .init(),
        validationSpy: ValidationSpy = .init(),
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> SignUpPresenter {
        let sut = SignUpPresenter(alertView: alertViewSpy,
                                  addAccount: addAccountSpy,
                                  loadingView: loadingViewSpy,
                                  validation: validationSpy)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
    
}
