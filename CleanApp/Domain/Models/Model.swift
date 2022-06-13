//
//  Model.swift
//  Domain
//
//  Created by Gilberto Silva on 11/06/22.
//

import Foundation

public protocol Model: Codable, Equatable {}

public extension Model {
    func toData() -> Data? {
        return try? JSONEncoder().encode(self)
    }
}
