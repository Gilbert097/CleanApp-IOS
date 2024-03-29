//
//  ValidationSpy.swift
//  PresentationTests
//
//  Created by Gilberto Silva on 28/03/23.
//

import Foundation
import Presentation

public class ValidationSpy: Validation {
    var data: [String: Any]?
    var errorMessage: String?
    
    public func validate(data: [String : Any]?) -> String? {
        self.data = data
        return errorMessage
    }
    
    public func simulateError() {
        self.errorMessage = "Erro"
    }
}
