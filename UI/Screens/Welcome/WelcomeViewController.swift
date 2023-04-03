//
//  WelcomeViewController.swift
//  UI
//
//  Created by Gilberto Silva on 03/04/23.
//

import Foundation
import UIKit
import Presentation

public final class WelcomeViewController: UIViewController {
    
    private let imageView: UIImageView = {
        let view = UIImageView(image: .image(named: "logo"))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let separetorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "SEJA BEM-VINDO"
        view.textColor = .white
        view.textAlignment = .center
        view.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return view
    }()
    
    public let loginButton: PrimaryButton = {
        PrimaryButton(
            title: "LOGIN",
            color: .white,
            textColor: Color.primary
        )
    }()
    
    private let separetorLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "OU"
        view.textColor = .white
        view.textAlignment = .center
        view.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return view
    }()
    
    public let signUpButton: PrimaryButton = {
        PrimaryButton(
            title: "CRIAR CONTA",
            color: .white,
            textColor: Color.primary
        )
    }()
    
    public var login: (() -> Void)?
    public var signUp: (() -> Void)?
    
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
        self.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        self.signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
    }
    
    @objc private func loginButtonTapped() {
        self.login?()
    }
    
    @objc private func signUpButtonTapped() {
        self.signUp?()
    }
}

// MARK: - ViewCode
extension WelcomeViewController: ViewCode {
    
    func setupViewHierarchy() {
        self.view.addSubviews([
            imageView,
            separetorView,
            titleLabel,
            loginButton,
            separetorLabel,
            signUpButton
        ])
    }
    
    func setupConstraints() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // imageView
        NSLayoutConstraint.activate([
            self.imageView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            self.imageView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 48),
            self.imageView.heightAnchor.constraint(equalToConstant: 90),
            self.imageView.widthAnchor.constraint(equalToConstant: 120)
        ])
        
        // separetorView
        NSLayoutConstraint.activate([
            self.separetorView.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 48),
            self.separetorView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 32),
            self.separetorView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -32),
            self.separetorView.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        // titleLabel
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.separetorView.bottomAnchor, constant: 48),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.separetorView.leadingAnchor),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.separetorView.trailingAnchor)
        ])

        // saveButton
        NSLayoutConstraint.activate([
            self.loginButton.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 40),
            self.loginButton.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor),
            self.loginButton.trailingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor),
            self.loginButton.heightAnchor.constraint(equalToConstant: 60)
        ])

        // separetorLabel
        NSLayoutConstraint.activate([
            self.separetorLabel.topAnchor.constraint(equalTo: self.loginButton.bottomAnchor, constant: 24),
            self.separetorLabel.leadingAnchor.constraint(equalTo: self.loginButton.leadingAnchor),
            self.separetorLabel.trailingAnchor.constraint(equalTo: self.loginButton.trailingAnchor)
        ])

        // signUpButton
        NSLayoutConstraint.activate([
            self.signUpButton.topAnchor.constraint(equalTo: self.separetorLabel.bottomAnchor, constant: 24),
            self.signUpButton.leadingAnchor.constraint(equalTo: self.separetorLabel.leadingAnchor),
            self.signUpButton.trailingAnchor.constraint(equalTo: self.separetorLabel.trailingAnchor),
            self.signUpButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        
    }
    
    func setupAdditionalConfiguration() {
        self.view.backgroundColor = Color.primary
    }
}
