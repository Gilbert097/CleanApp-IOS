//
//  SignUpPresenter.swift
//  Presentation
//
//  Created by Gilberto Silva on 13/09/22.
//

import Foundation
import Domain

public final class SignUpPresenter {
    private let alertView: AlertView
    private let addAccount: AddAccount
    private let loadingView: LoagingView
    private let validation: Validation
    
    public init(alertView: AlertView,
                addAccount: AddAccount,
                loadingView: LoagingView,
                validation: Validation) {
        self.alertView = alertView
        self.addAccount = addAccount
        self.loadingView = loadingView
        self.validation = validation
    }
    
    public func signUp(viewModel: SignUpViewModel){
        if let message = self.validation.validate(data: viewModel.toJson()) {
            self.alertView.showMessage(viewModel: AlertViewModel(title: "Falha na validação", message: message))
        } else {
            self.loadingView.display(viewModel: .init(isLoading: true))
            self.addAccount.add(addAccountModel: viewModel.toAddAccountModel()) { [weak self] result in
                guard let self = self else { return }
                
                self.loadingView.display(viewModel: .init(isLoading: false))
                switch result {
                case .success:
                    self.alertView.showMessage(viewModel: AlertViewModel(title: "Sucesso", message: "Conta criada com successo."))
                case .failure:
                    self.alertView.showMessage(viewModel: AlertViewModel(title: "Erro", message: "Algo inesperado aconteceu, tente novamente em alguns instantes."))
                }
            }
        }
    }
}
