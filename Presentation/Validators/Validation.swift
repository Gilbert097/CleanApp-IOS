//
//  Validation.swift
//  PresentationTests
//
//  Created by Gilberto Silva on 28/03/23.
//

import Foundation

public protocol Validation {
    func validate(data: [String: Any]?) -> String?
}
