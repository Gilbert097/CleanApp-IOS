//
//  AddAccountRemote.swift
//  Data
//
//  Created by Gilberto Silva on 11/06/22.
//

import Foundation
import Domain

public final class AddAccountRemote {
    private let url: URL
    private let httpPostClient: HttpPostClient
    
    public init(url: URL, httpPostClient: HttpPostClient) {
        self.url = url
        self.httpPostClient = httpPostClient
    }
    
    public func add(addAccountModel: AddAccountModel, completion: @escaping (DomainError) -> Void) {
        httpPostClient.post(to: url, with: addAccountModel.toData()) { error in
            completion(.unexpected)
        }
    }
}
