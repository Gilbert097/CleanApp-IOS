//
//  AccountModelFactory.swift
//  DataTests
//
//  Created by Gilberto Silva on 14/06/22.
//

import Foundation
import Domain

func makeAccountModel() -> AccountModel {
    return AccountModel(
        id: "any_id",
        name: "any_name",
        email: "any_name@mail.com",
        password: "any_password"
    )
}
