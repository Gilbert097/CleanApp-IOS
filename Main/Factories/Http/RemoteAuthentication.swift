//
//  RemoteAthenticationFactory.swift
//  Main
//
//  Created by Gilberto Silva on 03/04/23.
//

import Foundation
import Data
import Domain

func makeRemoteAuthentication() -> Authentication {
    makeRemoteAuthenticationWith(httpClient: makeAlamofireAdapter())
}

func makeRemoteAuthenticationWith(httpClient: HttpPostClient) -> Authentication {
    let remoteAddAccount = RemoteAuthentication(url: makeApiUrl(path: "login"), httpClient: httpClient)
    return MainQueueDispatchDecorator(remoteAddAccount)
}
