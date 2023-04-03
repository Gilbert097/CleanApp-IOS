//
//  WelcomeRouter.swift
//  UI
//
//  Created by Gilberto Silva on 03/04/23.
//

import Foundation

public class WelcomeRouter {
    private let nav: NavigationController
    private let loginFactory: () -> LoginViewController
    private let signUpFactory: () -> SignUpViewController
   
    public init(nav: NavigationController, loginFactory: @escaping () -> LoginViewController, signUpFactory: @escaping () -> SignUpViewController) {
        self.nav = nav
        self.loginFactory = loginFactory
        self.signUpFactory = signUpFactory
    }
   
    public func goToLogin() {
        nav.pushViewController(loginFactory())
    }
    
    public func goToSignUp() {
        nav.pushViewController(signUpFactory())
    }
}
