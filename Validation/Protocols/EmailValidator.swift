//
//  EmailValidator.swift
//  Validation
//
//  Created by Gilberto Silva on 13/09/22.
//

import Foundation

public protocol EmailValidator {
    func isValid(email: String) -> Bool
}
