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
    private let authentication: Authentication
    private let validation: Validation
    
    public init(alertView: AlertView,
                authentication: Authentication,
                validation: Validation) {
        self.alertView = alertView
        self.authentication = authentication
        self.validation = validation
    }
    
    public func login(viewModel: LoginViewModel){
        if let message = self.validation.validate(data: viewModel.toJson()) {
            self.alertView.showMessage(viewModel: AlertViewModel(title: "Falha na validação", message: message))
        } else {
            self.authentication.auth(authenticationModel: viewModel.toAuthenticationModel()) { [weak self] result in
                guard let self = self else { return }
                
                //self.loadingView.display(viewModel: .init(isLoading: false))
                switch result {
                case .success: break
                    //self.alertView.showMessage(viewModel: AlertViewModel(title: "Sucesso", message: "Conta criada com successo."))
                case .failure:
//                    var errorMessage: String!
//                    switch error {
//                    case .emailInUse:
//                        errorMessage = "Esse e-mail já está em uso."
//                    default:
//                        errorMessage = "Algo inesperado aconteceu, tente novamente em alguns instantes."
//                    }
                    self.alertView.showMessage(viewModel: AlertViewModel(title: "Erro", message: "Algo inesperado aconteceu, tente novamente em alguns instantes."))
                }
            }
        }
    }
}
