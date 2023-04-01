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

public func makeSignUpController(addAccount: AddAccount) -> SignUpViewController {
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
    [
        RequiredFieldValidation(fieldName: "name", fieldLabel: "Nome"),
        RequiredFieldValidation(fieldName: "email", fieldLabel: "Email"),
        EmailValidation(fieldName: "email", fieldLabel: "Email", emailValidator: makeEmailValidatorAdapter()),
        RequiredFieldValidation(fieldName: "password", fieldLabel: "Senha"),
        RequiredFieldValidation(fieldName: "passwordConfirmation", fieldLabel: "Confirmar Senha"),
        CompareFieldValidation(fieldName: "password", fieldNameToCompare: "passwordConfirmation", fieldLabel: "Confirmar Senha")
    ]
}
