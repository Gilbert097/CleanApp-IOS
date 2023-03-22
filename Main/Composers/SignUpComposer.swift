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

public final class SignUpComposer {
    public static func composeViewControllerWith(addAccount: AddAccount) -> SignUpViewController {
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
