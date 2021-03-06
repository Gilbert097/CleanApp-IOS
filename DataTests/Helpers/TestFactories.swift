//
//  TestFactories.swift
//  DataTests
//
//  Created by Gilberto Silva on 14/06/22.
//

import Foundation

func makeInvalidData() -> Data {
    return Data("invalid_data".utf8)
}

func makeUrl() -> URL {
    return URL(string: "http://any-url.com")!
}
