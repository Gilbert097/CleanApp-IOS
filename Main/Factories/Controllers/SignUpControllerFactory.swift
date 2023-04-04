//
//  SignUpComposer.swift
//  Main
//
//  Created by Gilberto Silva on 21/03/23.
//

import Foundation
import Domain
import UI
import Presentation
import Validation

public func makeSignUpController() -> SignUpViewController {
    makeSignUpControllerWith(addAccount: makeRemoteAddAccount())
}

public func makeSignUpControllerWith(addAccount: AddAccount) -> SignUpViewController {
    let controller = SignUpViewController()
    let validationComposite = ValidationComposite(validations: makeSignValidations())
    let presenter = SignUpPresenter(
        alertView: WeakVarProxy(controller),
        addAccount: addAccount,
        loadingView: WeakVarProxy(controller),
        validation: validationComposite)
    controller.signUp = presenter.signUp
    return controller
}

public func makeSignValidations() -> [Validation] {
    ValidationBuilder
        .field("name")
        .label("Nome")
        .required()
        .build()
    +
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
    +
    ValidationBuilder
        .field("passwordConfirmation")
        .label("Confirmar Senha")
        .sameAs("password")
        .build()
}
