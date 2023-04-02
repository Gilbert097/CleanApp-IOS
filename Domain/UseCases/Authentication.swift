//
//  Authentication.swift
//  Domain
//
//  Created by Gilberto Silva on 02/04/23.
//

import Foundation

public protocol Authentication {
    typealias Result = Swift.Result<AccountModel, DomainError>
    func auth(
        AuthenticationModel: AuthenticationModel,
        completion: @escaping (Result) -> Void
    )
}

public struct AuthenticationModel: Model {
    
    public var email: String
    public var password: String
    
    public init(
        email: String,
        password: String
    ) {
        self.email = email
        self.password = password
    }
}
