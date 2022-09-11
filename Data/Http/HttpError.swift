//
//  HttpError.swift
//  Domain
//
//  Created by Gilberto Silva on 12/06/22.
//

import Foundation

public enum HttpError: Error {
    case noConnectivity
    case badRequest
    case serverError
    case unauthorized
    case forbidden
}
