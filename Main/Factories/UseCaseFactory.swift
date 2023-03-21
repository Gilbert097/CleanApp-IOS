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
    
    static func makeRemoteAddAccount() -> AddAccount {
        let url = URL(string: "https://fordevs.herokuapp.com/api/signup")!
        let alamofireAdapter = AlamofireAdapter()
        return AddAccountRemote(url: url, httpPostClient: alamofireAdapter)
    }
}
