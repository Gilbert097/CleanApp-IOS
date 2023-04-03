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
    
    public init(nav: NavigationController,
                loginFactory: @escaping () -> LoginViewController) {
        self.nav = nav
        self.loginFactory = loginFactory
    }
    
    func goToLogin() {
        nav.pushViewController(loginFactory())
    }
}

class WelcomeRouterTests: XCTestCase {
    
    func test_gottoLogin_calls_nav_with_correct_vc() {
        let (sut, nav) = makeSut()
        sut.goToLogin()
        XCTAssertEqual(nav.viewControllers.count, 1)
        XCTAssertTrue(nav.viewControllers[0] is LoginViewController)
    }
}

extension WelcomeRouterTests {
    
    func makeSut() -> (sut: WelcomeRouter, nav: NavigationController) {
        let loginFactory = LoginFactorySpy()
        let nav = NavigationController()
        let sut = WelcomeRouter(nav: nav, loginFactory: loginFactory.makeLogin)
        return (sut, nav)
    }
    
    class LoginFactorySpy {
        func makeLogin() -> LoginViewController {
            LoginViewController()
        }
    }
}
