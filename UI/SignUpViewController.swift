//
//  SignUpViewController.swift
//  UI
//
//  Created by Gilberto Silva on 19/09/22.
//

import Foundation
import UIKit

final class SignUpViewController: UIViewController {
    
    public let loadingIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.style = UIActivityIndicatorView.Style.large
        view.hidesWhenStopped = true
        return view
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension SignUpViewController: ViewCode {
    
    func buildViewHierarchy() {
        self.view.addSubview(loadingIndicatorView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            self.loadingIndicatorView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.loadingIndicatorView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }
}
