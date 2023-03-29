//
//  EmailValidatorSpy.swift
//  ValidationTests
//
//  Created by Gilberto Silva on 18/09/22.
//

import Foundation
import Validation

class EmailValidatorSpy: EmailValidator {
    var isvalid = true
    var email: String?
    
    func isValid(email: String) -> Bool {
        self.email = email
        return isvalid
    }
    
    func simulateInvalidEmail() {
        self.isvalid = false
    }
}
