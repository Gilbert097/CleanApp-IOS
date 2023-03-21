//
//  SignUpFactory.swift
//  Main
//
//  Created by Gilberto Silva on 14/03/23.
//

import Foundation
import UI
import Presentation
import Validation
import Domain

class ControllerFactory {
    static func makeSignUp(addAccount: AddAccount) -> SignUpViewController {
        let controller = SignUpViewController()
        let emailValidatorAdapter = EmailValidatorAdapter()
        
        let presenter = SignUpPresenter(
            alertView: WeakVarProxy(controller) ,
            emailValidator: emailValidatorAdapter,
            addAccount: addAccount,
            loadingView: WeakVarProxy(controller))
        controller.signUp = presenter.signUp
        return controller
    }
}
