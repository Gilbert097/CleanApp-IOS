//
//  HttpPostClient.swift
//  Data
//
//  Created by Gilberto Silva on 11/06/22.
//

import Foundation
import Domain

public protocol HttpPostClient {
    func post(to url: URL, with data: Data?, completion: @escaping (HttpError) -> Void)
}
