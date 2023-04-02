//
//  AuthenticationSpy.swift
//  PresentationTests
//
//  Created by Gilberto Silva on 02/04/23.
//

import Foundation
import Domain

class AuthenticationSpy: Authentication {
    var authenticationModel: AuthenticationModel?
    var completion: ((Authentication.Result) -> Void)?
    
    func auth(authenticationModel: AuthenticationModel,
              completion: @escaping (Authentication.Result) -> Void) {
        self.authenticationModel = authenticationModel
        self.completion = completion
    }
    
    func completeWithError(_ error: DomainError) {
        self.completion?(.failure(error))
    }
    
    func completeWithAccount(_ account: AccountModel) {
        self.completion?(.success(account))
    }
}
