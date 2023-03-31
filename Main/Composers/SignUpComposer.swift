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
import Infra

public final class SignUpComposer {
    public static func composeViewControllerWith(addAccount: AddAccount) -> SignUpViewController {
        let controller = SignUpViewController()
        let validationComposite = ValidationComposite(validations: makeValidations())
        let presenter = SignUpPresenter(
            alertView: WeakVarProxy(controller),
            addAccount: addAccount,
            loadingView: WeakVarProxy(controller),
            validation: validationComposite)
        controller.signUp = presenter.signUp
        return controller
    }
    
    public static func makeValidations() -> [Validation] {
        [
            RequiredFieldValidation(fieldName: "name", fieldLabel: "Nome"),
            RequiredFieldValidation(fieldName: "email", fieldLabel: "Email"),
            EmailValidation(fieldName: "email", fieldLabel: "Email", emailValidator: EmailValidatorAdapter()),
            RequiredFieldValidation(fieldName: "password", fieldLabel: "Senha"),
            RequiredFieldValidation(fieldName: "passwordConfirmation", fieldLabel: "Confirmar Senha"),
            CompareFieldValidation(fieldName: "password", fieldNameToCompare: "passwordConfirmation", fieldLabel: "Confirmar Senha")
        ]
    }
}
