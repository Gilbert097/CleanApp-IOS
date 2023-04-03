//
//  WelcomeRouterTests.swift
//  UITests
//
//  Created by Gilberto Silva on 03/04/23.
//

import Foundation
import XCTest
import UIKit
import UI

class WelcomeRouter {
    private let nav: NavigationController
    private let loginFactory: () -> LoginViewController
    private let signUpFactory: () -> SignUpViewController
   
    public init(nav: NavigationController, loginFactory: @escaping () -> LoginViewController, signUpFactory: @escaping () -> SignUpViewController) {
        self.nav = nav
        self.loginFactory = loginFactory
        self.signUpFactory = signUpFactory
    }
   
    func goToLogin() {
        nav.pushViewController(loginFactory())
    }
    
    func goToSignUp() {
        nav.pushViewController(signUpFactory())
    }
}

class WelcomeRouterTests: XCTestCase {
    
    func test_gottoLogin_calls_nav_with_correct_vc() {
        let (sut, nav) = makeSut()
        sut.goToLogin()
        XCTAssertEqual(nav.viewControllers.count, 1)
        XCTAssertTrue(nav.viewControllers[0] is LoginViewController)
    }
    
    func test_gottoSignUp_calls_nav_with_correct_vc() {
        let (sut, nav) = makeSut()
        sut.goToSignUp()
        XCTAssertEqual(nav.viewControllers.count, 1)
        XCTAssertTrue(nav.viewControllers[0] is SignUpViewController)
    }
}

extension WelcomeRouterTests {
    
    func makeSut() -> (sut: WelcomeRouter, nav: NavigationController) {
        let loginFactory = LoginFactorySpy()
        let signUpFactory = SignUpFactorySpy()
        let nav = NavigationController()
        let sut = WelcomeRouter(nav: nav, loginFactory: loginFactory.makeLogin, signUpFactory: signUpFactory.makeSignUp)
        return (sut, nav)
    }
    
    class LoginFactorySpy {
        func makeLogin() -> LoginViewController {
            LoginViewController()
        }
    }
    
    class SignUpFactorySpy {
        func makeSignUp() -> SignUpViewController {
            SignUpViewController()
        }
    }
}
