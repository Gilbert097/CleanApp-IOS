//
//  ValidationSpy.swift
//  ValidationTests
//
//  Created by Gilberto Silva on 30/03/23.
//

import Foundation
import Presentation

public class ValidationSpy: Validation {
    var errorMessage: String?
    var data: [String : Any]?
    
    public func validate(data: [String : Any]?) -> String? {
        self.data = data
        return errorMessage
    }
    
    func simulateError(errorMessage: String) {
        self.errorMessage = errorMessage
    }
}
