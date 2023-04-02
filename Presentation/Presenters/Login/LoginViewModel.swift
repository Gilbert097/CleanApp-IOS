//
//  LoginViewModel.swift
//  Presentation
//
//  Created by Gilberto Silva on 02/04/23.
//

import Foundation
import Domain

public struct LoginViewModel: Model {
    
    public var email: String?
    public var password: String?
    
    public init(
        email: String? = nil,
        password: String? = nil
    ) {
        self.email = email
        self.password = password
    }
    
    func toAuthenticationModel() -> AuthenticationModel {
        AuthenticationModel(email: self.email!, password: self.password!)
    }
}
