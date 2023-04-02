//
//  SignUpPresenter.swift
//  Presentation
//
//  Created by Gilberto Silva on 02/04/22.
//

import Foundation
import Domain

public final class LoginPresenter {
    
    private let alertView: AlertView
    private let validation: Validation
    
    public init(alertView: AlertView, validation: Validation) {
        self.alertView = alertView
        self.validation = validation
    }
    
    public func login(viewModel: LoginViewModel){
        if let message = self.validation.validate(data: viewModel.toJson()) {
            self.alertView.showMessage(viewModel: AlertViewModel(title: "Falha na validação", message: message))
        }
    }
}
