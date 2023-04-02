//
//  SignUpViewController.swift
//  UI
//
//  Created by Gilberto Silva on 19/09/22.
//

import Foundation
import UIKit
import Presentation

public final class SignUpViewController: UIViewController {
    
    private let loadingIndicatorView: UIActivityIndicatorView = {
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
        view.text = "CADASTRO"
        view.textColor = Color.primary
        view.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return view
    }()
    
    private let nameTextField: HighlightedTextField = {
        let view = HighlightedTextField()
        view.placeholder = "Nome"
        return view
    }()
    
    private let emailTextField: HighlightedTextField = {
        let view = HighlightedTextField()
        view.placeholder = "Email"
        view.keyboardType = .emailAddress
        return view
    }()
    
    private let passwordTextField: HighlightedTextField = {
        let view = HighlightedTextField()
        view.placeholder = "Senha"
        view.isSecureTextEntry = true
        return view
    }()
    
    private let passwordConfirmationTextField: HighlightedTextField = {
        let view = HighlightedTextField()
        view.placeholder = "Confirmar senha"
        view.isSecureTextEntry = true
        return view
    }()
    
    private let saveButton = PrimaryButton(title: "CRIAR CONTA")
    
    public var signUp: ((SignUpViewModel) -> Void)?
    
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
    
    func setupViewHierarchy() {
        header.addSubview(imageView)
        self.view.addSubviews([header,
                               titleLabel,
                               nameTextField,
                               emailTextField,
                               passwordTextField,
                               passwordConfirmationTextField,
                               saveButton,
                               loadingIndicatorView
                              ])
    }
    
    func setupConstraints() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        //        // header
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
        
        // nameTextField
        NSLayoutConstraint.activate([
            self.nameTextField.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 16),
            self.nameTextField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 32),
            self.nameTextField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -32),
            self.nameTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // emailTextField
        NSLayoutConstraint.activate([
            self.emailTextField.topAnchor.constraint(equalTo: self.nameTextField.bottomAnchor, constant: 16),
            self.emailTextField.leadingAnchor.constraint(equalTo: self.nameTextField.leadingAnchor),
            self.emailTextField.trailingAnchor.constraint(equalTo: self.nameTextField.trailingAnchor),
            self.emailTextField.heightAnchor.constraint(equalTo: self.nameTextField.heightAnchor)
        ])
        
        // passwordTextField
        NSLayoutConstraint.activate([
            self.passwordTextField.topAnchor.constraint(equalTo: self.emailTextField.bottomAnchor, constant: 16),
            self.passwordTextField.leadingAnchor.constraint(equalTo: self.nameTextField.leadingAnchor),
            self.passwordTextField.trailingAnchor.constraint(equalTo: self.nameTextField.trailingAnchor),
            self.passwordTextField.heightAnchor.constraint(equalTo: self.nameTextField.heightAnchor)
        ])
        
        // passwordConfirmationTextField
        NSLayoutConstraint.activate([
            self.passwordConfirmationTextField.topAnchor.constraint(equalTo: self.passwordTextField.bottomAnchor, constant: 16),
            self.passwordConfirmationTextField.leadingAnchor.constraint(equalTo: self.nameTextField.leadingAnchor),
            self.passwordConfirmationTextField.trailingAnchor.constraint(equalTo: self.nameTextField.trailingAnchor),
            self.passwordConfirmationTextField.heightAnchor.constraint(equalTo: self.nameTextField.heightAnchor)
        ])
        
        // saveButton
        NSLayoutConstraint.activate([
            self.saveButton.topAnchor.constraint(equalTo: self.passwordConfirmationTextField.bottomAnchor, constant: 32),
            self.saveButton.leadingAnchor.constraint(equalTo: self.nameTextField.leadingAnchor),
            self.saveButton.trailingAnchor.constraint(equalTo: self.nameTextField.trailingAnchor),
            self.saveButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        // loadingIndicatorView
        NSLayoutConstraint.activate([
            self.loadingIndicatorView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            self.loadingIndicatorView.topAnchor.constraint(equalTo: self.saveButton.bottomAnchor, constant: 16)
        ])
    }
    
    func setupAdditionalConfiguration() {
        self.view.backgroundColor = .white
    }
}

// MARK: - LoagingView
extension SignUpViewController: LoagingView {
    
    public func display(viewModel: LoagingViewModel) {
        if viewModel.isLoading {
            self.loadingIndicatorView.startAnimating()
        } else {
            self.loadingIndicatorView.stopAnimating()
        }
    }
}

// MARK: - AlertView
extension SignUpViewController: AlertView {
    
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
