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

class SignUpViewControllerTests: XCTestCase {

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
    
    func test_saveButton_calls_sigup_on_tap() {
        var viewModel: SignUpRequest?
        let sut = makeSut(signUp: { viewModel = $0 })
        sut.saveButton.simulateTap()
      
        let viewModelSpy = SignUpRequest(
            name: sut.nameTextField.text,
            email: sut.emailTextField.text,
            password: sut.passwordTextField.text,
            passwordConfirmation: sut.passwordConfirmationTextField.text
        )
        XCTAssertEqual(viewModel, viewModelSpy)
    }
}

extension SignUpViewControllerTests {
    
    private func makeSut(signUp: ((SignUpRequest) -> Void)? = nil) -> SignUpViewController{
        let sut = SignUpViewController()
        sut.signUp = signUp
        sut.loadViewIfNeeded()
        return sut
    }
}
