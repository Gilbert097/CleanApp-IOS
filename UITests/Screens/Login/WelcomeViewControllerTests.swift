//
//  WelcomeViewControllerTests.swift
//  UITests
//
//  Created by Gilberto Silva on 19/09/22.
//

import XCTest
import UIKit
import Presentation
@testable import UI

class WelcomeViewControllerTests: XCTestCase {

    func test_loginButton_calls_login_on_tap() {
        let (sut, buttonSpy) = makeSut()
        sut.loginButton.simulateTap()
        XCTAssertEqual(buttonSpy.clicks, 1)
    }
    
    func test_signUpButton_calls_signUp_on_tap() {
        let (sut, buttonSpy) = makeSut()
        sut.signUpButton.simulateTap()
        XCTAssertEqual(buttonSpy.clicks, 1)
    }
}

extension WelcomeViewControllerTests {
    
    private func makeSut() -> (sut: WelcomeViewController, buttonSpy: ButtonSpy) {
        let buttonSpy = ButtonSpy()
        let sut = WelcomeViewController()
        sut.login = buttonSpy.onClick
        sut.signUp = buttonSpy.onClick
        sut.loadViewIfNeeded()
        return (sut, buttonSpy)
    }
    
    class ButtonSpy {
        var clicks = 0
        
        func onClick() {
            clicks += 1
        }
    }
}
