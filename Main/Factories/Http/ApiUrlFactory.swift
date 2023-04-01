//
//  UseCaseFactory.swift
//  Main
//
//  Created by Gilberto Silva on 21/03/23.
//

import Foundation

func makeApiUrl(path: String) -> URL {
    URL(string: "\(Enviroment.variable(.apiBaseUrl))/\(path)")!
}
