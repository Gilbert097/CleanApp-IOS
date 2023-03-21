//
//  SignUpComposer.swift
//  Main
//
//  Created by Gilberto Silva on 21/03/23.
//

import Foundation
import Domain
import UI

public final class SignUpComposer {
    static func composeViewControllerWith(addAccount: AddAccount) -> SignUpViewController {
        return ControllerFactory.makeSignUp(addAccount: addAccount)
    }
}
