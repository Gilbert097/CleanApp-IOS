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
    private let loadingView: LoagingView
    private let validation: Validation
    
    public init(alertView: AlertView,
                authentication: Authentication,
                loadingView: LoagingView,
                validation: Validation) {
        self.alertView = alertView
        self.authentication = authentication
        self.loadingView = loadingView
        self.validation = validation
    }
    
    public func login(viewModel: LoginViewModel){
        if let message = self.validation.validate(data: viewModel.toJson()) {
            self.alertView.showMessage(viewModel: AlertViewModel(title: "Falha na validação", message: message))
        } else {
            self.loadingView.display(viewModel: .init(isLoading: true))
            self.authentication.auth(authenticationModel: viewModel.toAuthenticationModel()) { [weak self] result in
                guard let self = self else { return }
                
                self.loadingView.display(viewModel: .init(isLoading: false))
                switch result {
                case .success:
                    self.alertView.showMessage(viewModel: AlertViewModel(title: "Sucesso", message: "Login feito com successo."))
                case .failure(let error):
                    var errorMessage: String!
                    switch error {
                    case .expiredSession:
                        errorMessage = "Email e/ou senha inválidos."
                    default:
                        errorMessage = "Algo inesperado aconteceu, tente novamente em alguns instantes."
                    }
                    self.alertView.showMessage(viewModel: AlertViewModel(title: "Erro", message: errorMessage))
                }
            }
        }
    }
}
