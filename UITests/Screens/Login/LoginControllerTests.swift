//
//  UITests.swift
//  UITests
//
//  Created by Gilberto Silva on 19/09/22.
//

import XCTest
import UIKit
import Presentation
@testable import UI

class LoginControllerTests: XCTestCase {

    func test_loading_is_hidden_on_start() throws {
        let sut = makeSut()
        XCTAssertEqual(sut.loadingIndicatorView.isAnimating, false)
    }
    
    func test_sut_implements_loadingView() {
        let sut = makeSut()
        XCTAssertNotNil(sut as LoagingView)
    }
    
    func test_sut_implements_alertView() {
        let sut = makeSut()
        XCTAssertNotNil(sut as AlertView)
    }
    
    func test_loginButton_calls_login_on_tap() {
        var viewModel: LoginViewModel?
        let sut = makeSut(loginSpy: { viewModel = $0 })
        sut.loginButton.simulateTap()
      
        let viewModelSpy = LoginViewModel(
            email: sut.emailTextField.text,
            password: sut.passwordTextField.text
        )
        XCTAssertEqual(viewModel, viewModelSpy)
    }
}

extension LoginControllerTests {
    
    private func makeSut(loginSpy: ((LoginViewModel) -> Void)? = nil) -> LoginViewController{
        let sut = LoginViewController()
        sut.login = loginSpy
        sut.loadViewIfNeeded()
        return sut
    }
}
