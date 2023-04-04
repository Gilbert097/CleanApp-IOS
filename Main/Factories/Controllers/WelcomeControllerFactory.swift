//
//  WelcomeControllerFactory.swift
//  Main
//
//  Created by Gilberto Silva on 04/04/23.
//

import Foundation
import UI

public func makeWelcomeController(nav: NavigationController) -> WelcomeViewController {
    let router = WelcomeRouter(nav: nav, loginFactory: makeLoginController, signUpFactory: makeSignUpController)
    let viewController = WelcomeViewController()
    viewController.login = router.goToLogin
    viewController.signUp = router.goToSignUp
    return viewController
}

