//
//  AddAccountSpy.swift
//  PresentationTests
//
//  Created by Gilberto Silva on 18/09/22.
//

import Foundation
import Domain

class AddAccountSpy: AddAccount {
    var addAccountModel: AddAccountModel?
    var completion: ((AddAccount.Result) -> Void)?
    
    func add(addAccountModel: AddAccountModel,
             completion: @escaping (AddAccount.Result) -> Void) {
        self.addAccountModel = addAccountModel
        self.completion = completion
    }
    
    func completeWithError(_ error: DomainError) {
        self.completion?(.failure(error))
    }
    
    func completeWithAccount(_ account: AccountModel) {
        self.completion?(.success(account))
    }
}
