//
//  Enviroment.swift
//  Main
//
//  Created by Gilberto Silva on 22/03/23.
//

import Foundation

public final class Enviroment {
    
    public enum EnviomentVariables: String {
        case apiBaseUrl = "API_BASE_URL"
    }
    
    public static func variable(_ key: EnviomentVariables) -> String {
        Bundle.main.infoDictionary![key.rawValue] as! String
    }
}
