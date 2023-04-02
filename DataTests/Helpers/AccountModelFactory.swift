//
//  AccountModelFactory.swift
//  DataTests
//
//  Created by Gilberto Silva on 14/06/22.
//

import Foundation
import Domain

func makeAccountModel() -> AccountModel {
    AccountModel(accessToken: "any_access_token")
}

func makeAddAccountModel() -> AddAccountModel {
    return AddAccountModel(
        name: "any_name",
        email:  "any_email@mail.com",
        password: "any_password",
        passwordConfirmation: "any_password"
    )
}

func makeAuthenticationModel() -> AuthenticationModel {
    return AuthenticationModel(email: "any_email@mail.com", password: "any_password")
}
