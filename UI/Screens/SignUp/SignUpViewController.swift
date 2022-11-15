//
//  SignUpViewController.swift
//  UI
//
//  Created by Gilberto Silva on 19/09/22.
//

import Foundation
import UIKit
import Presentation

final class SignUpViewController: UIViewController {
    
    public let loadingIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.style = UIActivityIndicatorView.Style.large
        view.hidesWhenStopped = true
        return view
    }()
    
    public let saveButton = UIButton()
    public let nameTextField = UITextField()
    public let emailTextField = UITextField()
    public let passwordTextField = UITextField()
    public let passwordConfirmationTextField = UITextField()
    
    public var signUp: ((SignUpViewModel) -> Void)?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        self.saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    @objc private func saveButtonTapped() {
        let viewModel = SignUpViewModel(
            name: nameTextField.text,
            email: emailTextField.text,
            password: passwordTextField.text,
            passwordConfirmation: passwordConfirmationTextField.text
        )
        self.signUp?(viewModel)
    }
}

// MARK: - ViewCode
extension SignUpViewController: ViewCode {
    
    func buildViewHierarchy() {
        self.view.addSubviews([loadingIndicatorView,
                               saveButton,
                               nameTextField,
                               emailTextField,
                               passwordTextField,
                               passwordConfirmationTextField])
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            self.loadingIndicatorView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.loadingIndicatorView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }
}

// MARK: - LoagingView
extension SignUpViewController: LoagingView {
    
    func display(viewModel: LoagingViewModel) {
        if viewModel.isLoading {
            self.loadingIndicatorView.startAnimating()
        } else {
            self.loadingIndicatorView.stopAnimating()
        }
    }
}

// MARK: - AlertView
extension SignUpViewController: AlertView {
    
    func showMessage(viewModel: Presentation.AlertViewModel) {
        let alert = UIAlertController(
            title: viewModel.title,
            message: viewModel.message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
}
