//
//  LoginViewController.swift
//  UI
//
//  Created by Gilberto Silva on 02/04/23.
//

import Foundation
import UIKit
import Presentation

public final class LoginViewController: UIViewController {
    
    public let loadingIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.hidesWhenStopped = true
        view.color = Color.primary
        return view
    }()
    
    private let header: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Color.primary
        return view
    }()
    
    private let imageView: UIImageView = {
        let view = UIImageView(image: .image(named: "logo"))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "LOGIN"
        view.textColor = Color.primary
        view.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return view
    }()
    
    
    public let emailTextField: HighlightedTextField = {
        let view = HighlightedTextField()
        view.placeholder = "Email"
        view.keyboardType = .emailAddress
        return view
    }()
    
    public let passwordTextField: HighlightedTextField = {
        let view = HighlightedTextField()
        view.placeholder = "Senha"
        view.isSecureTextEntry = true
        return view
    }()
    
    public let loginButton = PrimaryButton(title: "ENTRAR")
    
    public var login: ((LoginViewModel) -> Void)?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configure()
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    private func configure() {
        self.title = "4Dev"
        self.loginButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    @objc private func saveButtonTapped() {
        let viewModel = LoginViewModel(
            email: emailTextField.text,
            password: passwordTextField.text
        )
        self.login?(viewModel)
    }
}

// MARK: - ViewCode
extension LoginViewController: ViewCode {
    
    func setupViewHierarchy() {
        header.addSubview(imageView)
        self.view.addSubviews([header,
                               titleLabel,
                               emailTextField,
                               passwordTextField,
                               loginButton,
                               loadingIndicatorView
                              ])
    }
    
    func setupConstraints() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // header
        NSLayoutConstraint.activate([
            self.header.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 0),
            self.header.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 0),
            self.header.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 0)
        ])
        
        // imageView
        NSLayoutConstraint.activate([
            self.imageView.centerXAnchor.constraint(equalTo: self.header.centerXAnchor),
            self.imageView.topAnchor.constraint(equalTo: self.header.topAnchor, constant: 56),
            self.imageView.bottomAnchor.constraint(equalTo: self.header.bottomAnchor, constant: -56),
            self.imageView.heightAnchor.constraint(equalToConstant: 90),
            self.imageView.widthAnchor.constraint(equalToConstant: 120)
        ])
        
        // titleLabel
        NSLayoutConstraint.activate([
            self.titleLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            self.titleLabel.topAnchor.constraint(equalTo: self.header.bottomAnchor, constant: 24)
        ])
        
        // emailTextField
        NSLayoutConstraint.activate([
            self.emailTextField.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 16),
            self.emailTextField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 32),
            self.emailTextField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -32),
            self.emailTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // passwordTextField
        NSLayoutConstraint.activate([
            self.passwordTextField.topAnchor.constraint(equalTo: self.emailTextField.bottomAnchor, constant: 16),
            self.passwordTextField.leadingAnchor.constraint(equalTo: self.emailTextField.leadingAnchor),
            self.passwordTextField.trailingAnchor.constraint(equalTo: self.emailTextField.trailingAnchor),
            self.passwordTextField.heightAnchor.constraint(equalTo: self.emailTextField.heightAnchor)
        ])
        
        // saveButton
        NSLayoutConstraint.activate([
            self.loginButton.topAnchor.constraint(equalTo: self.passwordTextField.bottomAnchor, constant: 32),
            self.loginButton.leadingAnchor.constraint(equalTo: self.emailTextField.leadingAnchor),
            self.loginButton.trailingAnchor.constraint(equalTo: self.emailTextField.trailingAnchor),
            self.loginButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        // loadingIndicatorView
        NSLayoutConstraint.activate([
            self.loadingIndicatorView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            self.loadingIndicatorView.topAnchor.constraint(equalTo: self.loginButton.bottomAnchor, constant: 16)
        ])
    }
    
    func setupAdditionalConfiguration() {
        self.view.backgroundColor = .white
    }
}

// MARK: - LoagingView
extension LoginViewController: LoagingView {
    
    public func display(viewModel: LoagingViewModel) {
        if viewModel.isLoading {
            self.loadingIndicatorView.startAnimating()
        } else {
            self.loadingIndicatorView.stopAnimating()
        }
    }
}

// MARK: - AlertView
extension LoginViewController: AlertView {
    
    public func showMessage(viewModel: Presentation.AlertViewModel) {
        let alert = UIAlertController(
            title: viewModel.title,
            message: viewModel.message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
}
