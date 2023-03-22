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
        URL(string: "\(apiBaseUrl)/\(path)")!
    }
    
    static func makeRemoteAddAccount() -> AddAccount {
       AddAccountRemote(url: makeUrl(path: "signup"), httpClient: httpPostClient)
    }
}
