//
//  LoginControllerFactory.swift
//  Main
//
//  Created by Gilberto Silva on 21/03/23.
//

import Foundation
import Domain
import UI
import Presentation
import Validation

public func makeLoginController() -> LoginViewController {
    makeLoginControllerWith(authentication: makeRemoteAuthentication())
}

public func makeLoginControllerWith(authentication: Authentication) -> LoginViewController {
    let controller = LoginViewController()
    let validationComposite = ValidationComposite(validations: makeLoginValidations())
    let presenter = LoginPresenter(
        alertView: WeakVarProxy(controller),
        authentication: authentication,
        loadingView: WeakVarProxy(controller),
        validation: validationComposite)
    controller.login = presenter.login
    return controller
}

public func makeLoginValidations() -> [Validation] {
    ValidationBuilder
        .field("email")
        .label("Email")
        .required()
        .email()
        .build()
    +
    ValidationBuilder
        .field("password")
        .label("Senha")
        .required()
        .build()
}
