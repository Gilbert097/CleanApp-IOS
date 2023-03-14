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
import Data
import Infra

class SignUpFactory {
    static func makeController() -> SignUpViewController {
        let controller = SignUpViewController()
        let emailValidatorAdapter = EmailValidatorAdapter()
        let url = URL(string: "https://fordevs.herokuapp.com/api/signup")!
        let alamofireAdapter = AlamofireAdapter()
        let remoteAddAcctount = AddAccountRemote(url: url, httpPostClient: alamofireAdapter)
        
        let presenter = SignUpPresenter(
            alertView: controller,
            emailValidator: emailValidatorAdapter,
            addAccount: remoteAddAcctount,
            loadingView: controller)
        controller.signUp = presenter.signUp
        return controller
    }
}
