//
//  UseCaseFactory.swift
//  Main
//
//  Created by Gilberto Silva on 21/03/23.
//

import Foundation
import Data
import Infra
import Domain

final class UseCaseFactory {
    private static let httpPostClient = AlamofireAdapter()
    private static let apiBaseUrl = "https://fordevs.herokuapp.com/api"
    
    private static func makeUrl(path: String) -> URL {
        URL(string: "\(Enviroment.variable(.apiBaseUrl))/\(path)")!
    }
    
    static func makeRemoteAddAccount() -> AddAccount {
        let remoteAddAccount = RemoteAddAccount(url: makeUrl(path: "signup"), httpClient: httpPostClient)
        return MainQueueDispatchDecorator(remoteAddAccount)
    }
}

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
                    completion: @escaping (Result<AccountModel, DomainError>) -> Void) {
        
        self.instance.add(addAccountModel: addAccountModel) { [weak self] result in
            self?.dispatch { completion(result) }
        }
    }
}
