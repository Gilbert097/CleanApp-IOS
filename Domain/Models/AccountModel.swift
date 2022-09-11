//
//  AccountModel.swift
//  Domain
//
//  Created by Gilberto Silva on 11/06/22.
//

import Foundation

public struct AccountModel: Model {
    
    public var accessToken: String
    
    public init(accessToken: String) {
        self.accessToken = accessToken
    }
}
