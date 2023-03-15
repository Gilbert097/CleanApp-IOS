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
    
    public let loadingIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.hidesWhenStopped = true
        return view
    }()
    
    public let iconLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 90)
        view.text = "📱"
        return view
    }()
    
    public let titleLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 30, weight: .bold)
        view.text = "FavLang"
        view.textColor = UIColor.systemIndigo
        return view
    }()
    
    public let nameTextField: MyTextField = {
        let view = MyTextField()
        view.placeholder = "Nome"
        return view
    }()
    
    public let emailTextField: MyTextField = {
        let view = MyTextField()
        view.placeholder = "Email"
        view.keyboardType = .emailAddress
        return view
    }()
    
    public let passwordTextField: MyTextField = {
        let view = MyTextField()
        view.placeholder = "Senha"
        view.isSecureTextEntry = true
        return view
    }()
    
    public let passwordConfirmationTextField: MyTextField = {
        let view = MyTextField()
        view.placeholder = "Confirmar senha"
        view.isSecureTextEntry = true
        return view
    }()
    
    public let saveButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
        view.contentHorizontalAlignment = .left
        
        if #available(iOS 15.0, *) {
            var config = UIButton.Configuration.filled()
            config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 0)
            var container = AttributeContainer()
            container.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
            config.attributedTitle = AttributedString("Cadastrar", attributes: container)
            config.baseBackgroundColor = UIColor.systemIndigo
            view.configuration = config
        } else {
            view.setTitleColor(.white, for: .normal)
            view.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
            view.backgroundColor = UIColor.systemIndigo
            view.contentEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
            view.setTitle("Cadastrar", for: .normal)
        }
        return view
    }()
    
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
        self.view.addSubviews([iconLabel,
                               titleLabel,
                               nameTextField,
                               emailTextField,
                               passwordTextField,
                               passwordConfirmationTextField,
                               saveButton,
                               loadingIndicatorView])
    }
    
    func setupConstraints() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // iconLabel
        NSLayoutConstraint.activate([
            self.iconLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20),
            self.iconLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
        
        // titleLabel
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: iconLabel.bottomAnchor, constant: 10),
            self.titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
        
        // nameTextField
        NSLayoutConstraint.activate([
            self.nameTextField.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 50),
            self.nameTextField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            self.nameTextField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            self.nameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        // emailTextField
        NSLayoutConstraint.activate([
            self.emailTextField.topAnchor.constraint(equalTo: self.nameTextField.bottomAnchor, constant: 10),
            self.emailTextField.leadingAnchor.constraint(equalTo: self.nameTextField.leadingAnchor),
            self.emailTextField.trailingAnchor.constraint(equalTo: self.nameTextField.trailingAnchor),
            self.emailTextField.heightAnchor.constraint(equalTo: self.nameTextField.heightAnchor)
        ])
        
        // passwordTextField
        NSLayoutConstraint.activate([
            self.passwordTextField.topAnchor.constraint(equalTo: self.emailTextField.bottomAnchor, constant: 10),
            self.passwordTextField.leadingAnchor.constraint(equalTo: self.nameTextField.leadingAnchor),
            self.passwordTextField.trailingAnchor.constraint(equalTo: self.nameTextField.trailingAnchor),
            self.passwordTextField.heightAnchor.constraint(equalTo: self.nameTextField.heightAnchor)
        ])
        
        // passwordConfirmationTextField
        NSLayoutConstraint.activate([
            self.passwordConfirmationTextField.topAnchor.constraint(equalTo: self.passwordTextField.bottomAnchor, constant: 10),
            self.passwordConfirmationTextField.leadingAnchor.constraint(equalTo: self.nameTextField.leadingAnchor),
            self.passwordConfirmationTextField.trailingAnchor.constraint(equalTo: self.nameTextField.trailingAnchor),
            self.passwordConfirmationTextField.heightAnchor.constraint(equalTo: self.nameTextField.heightAnchor)
        ])
        
        // saveButton
        NSLayoutConstraint.activate([
            self.saveButton.topAnchor.constraint(equalTo: self.passwordConfirmationTextField.bottomAnchor, constant: 50),
            self.saveButton.leadingAnchor.constraint(equalTo: self.nameTextField.leadingAnchor),
            self.saveButton.trailingAnchor.constraint(equalTo: self.nameTextField.trailingAnchor),
            self.saveButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        // loadingIndicatorView
        NSLayoutConstraint.activate([
            self.loadingIndicatorView.centerYAnchor.constraint(equalTo: self.saveButton.centerYAnchor),
            self.loadingIndicatorView.trailingAnchor.constraint(equalTo: self.saveButton.trailingAnchor, constant: -10)
        ])
    }
    
    func setupAdditionalConfiguration() {
        self.view.backgroundColor = .black
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
