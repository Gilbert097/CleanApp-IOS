//
//  MainQueueDispatchDecorator.swift
//  Main
//
//  Created by Gilberto Silva on 24/03/23.
//

import Foundation
import Domain

public final class MainQueueDispatchDecorator<T> {
    
    private let instance: T
    
    public init(_ instance: T) {
        self.instance = instance
    }
    
    func dispatch(_ completion: @escaping () -> Void) {
        guard Thread.isMainThread else { return DispatchQueue.main.async(execute: completion)}
        completion()
    }
}

extension MainQueueDispatchDecorator: AddAccount where T: AddAccount{
    public func add(addAccountModel: AddAccountModel,
                    completion: @escaping (AddAccount.Result) -> Void) {
        
        self.instance.add(addAccountModel: addAccountModel) { [weak self] result in
            self?.dispatch { completion(result) }
        }
    }
}

extension MainQueueDispatchDecorator: Authentication where T: Authentication{
    public func auth(authenticationModel: AuthenticationModel,
                    completion: @escaping (Authentication.Result) -> Void) {
        
        self.instance.auth(authenticationModel: authenticationModel) { [weak self] result in
            self?.dispatch { completion(result) }
        }
    }
}
