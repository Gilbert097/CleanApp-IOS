//
//  ExtensionHelpers.swift
//  Data
//
//  Created by Gilberto Silva on 12/06/22.
//

import Foundation

extension Data {
    func toModel<T: Decodable>() -> T? {
        return try? JSONDecoder().decode(T.self, from: self)
    }
}
