//
//  EmailValidation.swift
//  Validation
//
//  Created by Gilberto Silva on 30/03/23.
//

import Foundation
import Presentation

public class EmailValidation: Validation {
    private let fieldName: String
    private let fieldLabel: String
    private let emailValidator: EmailValidator
    
    public init(fieldName: String, fieldLabel: String, emailValidator: EmailValidator) {
        self.fieldName = fieldName
        self.fieldLabel = fieldLabel
        self.emailValidator = emailValidator
    }
    
    public func validate(data: [String : Any]?) -> String? {
        guard
            let fieldNameValue = data?[fieldName] as? String,
            emailValidator.isValid(email: fieldNameValue)
        else {
            return "O campo \(fieldLabel) é inválido"
        }
        return nil
    }
}
