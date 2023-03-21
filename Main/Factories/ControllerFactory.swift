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

public class WeakVarProxy<T: AnyObject> {
   
    private weak var instance: T?
    
    init(_ instance: T?) {
        self.instance = instance
    }
}

extension WeakVarProxy: AlertView where T: AlertView {
    
    public func showMessage(viewModel: Presentation.AlertViewModel) {
        self.instance?.showMessage(viewModel: viewModel)
    }
}

extension WeakVarProxy: LoagingView where T: LoagingView {
    
    public func display(viewModel: Presentation.LoagingViewModel) {
        self.instance?.display(viewModel: viewModel)
    }
}
