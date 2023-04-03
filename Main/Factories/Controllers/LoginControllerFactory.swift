//
//  LoginControllerFactory..swift
//  Main
//
//  Created by Gilberto Silva on 21/03/23.
//

import Foundation
import Domain
import UI
import Presentation
import Validation

public func makeLoginController(authentication: Authentication) -> LoginViewController {
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
    [
        RequiredFieldValidation(fieldName: "email", fieldLabel: "Email"),
        EmailValidation(fieldName: "email", fieldLabel: "Email", emailValidator: makeEmailValidatorAdapter()),
        RequiredFieldValidation(fieldName: "password", fieldLabel: "Senha")
    ]
}
