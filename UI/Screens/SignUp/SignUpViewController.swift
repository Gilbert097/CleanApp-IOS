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
        let view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.style = UIActivityIndicatorView.Style.large
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
    
    public let nameTextField: UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.placeholder = "Nome"
        view.font = UIFont.systemFont(ofSize: 14)
        view.borderStyle = UITextField.BorderStyle.roundedRect
        view.autocorrectionType = UITextAutocorrectionType.no
        view.keyboardType = UIKeyboardType.default
        view.returnKeyType = UIReturnKeyType.done
        view.clearButtonMode = UITextField.ViewMode.whileEditing
        view.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        return view
    }()
    
    public let emailTextField = UITextField()
    public let passwordTextField = UITextField()
    public let passwordConfirmationTextField = UITextField()
    
    public let saveButton = UIButton()
    
    public var signUp: ((SignUpViewModel) -> Void)?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
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
    
    func setupViewHierarchy() {
        self.view.addSubviews([iconLabel,
                               titleLabel,
                               nameTextField,
                               saveButton,
                               emailTextField,
                               passwordTextField,
                               passwordConfirmationTextField,
                               loadingIndicatorView,])
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
        
        // loadingIndicatorView
        NSLayoutConstraint.activate([
            self.loadingIndicatorView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.loadingIndicatorView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
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
