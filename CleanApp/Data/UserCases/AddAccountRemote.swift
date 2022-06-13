//
//  AddAccountRemote.swift
//  Data
//
//  Created by Gilberto Silva on 11/06/22.
//

import Foundation
import Domain

public final class AddAccountRemote: AddAccount {
    private let url: URL
    private let httpPostClient: HttpPostClient
    
    public init(url: URL, httpPostClient: HttpPostClient) {
        self.url = url
        self.httpPostClient = httpPostClient
    }
    
    public func add(
        addAccountModel: AddAccountModel,
        completion: @escaping (Result<AccountModel, DomainError>) -> Void
    ) {
        httpPostClient.post(to: url, with: addAccountModel.toData()) { result in
            switch(result){
            case .success(let data):
                if let model: AccountModel = data.toModel() {
                    completion(.success(model))
                } else {
                    completion(.failure(.unexpected))
                }
            case .failure:
                completion(.failure(.unexpected))
            }
        }
    }
}
