//
//  RequiredFieldValidation.swift
//  Validation
//
//  Created by Gilberto Silva on 29/03/23.
//

import Foundation
import Presentation

public class RequiredFieldValidation: Validation {
    private let fieldName: String
    private let fieldLabel: String
    
    public init(fieldName: String, fieldLabel: String) {
        self.fieldName = fieldName
        self.fieldLabel = fieldLabel
    }
    
    public func validate(data: [String : Any]?) -> String? {
        guard
            let fieldName = data?[fieldName] as? String,
            !fieldName.isEmpty
        else {
            return "O campo \(fieldLabel) é obrigatório"
        }
        return nil
    }
}
