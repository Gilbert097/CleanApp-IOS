//
//  UseCaseFactory.swift
//  Main
//
//  Created by Gilberto Silva on 21/03/23.
//

import Foundation
import Data
import Domain

func makeRemoteAddAccount(httpClient: HttpPostClient) -> AddAccount {
    let remoteAddAccount = RemoteAddAccount(url: makeApiUrl(path: "signup"), httpClient: httpClient)
    return MainQueueDispatchDecorator(remoteAddAccount)
}
