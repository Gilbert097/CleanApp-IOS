//
//  CleanAppBundle.swift
//  UI
//
//  Created by Gilberto Silva on 01/04/23.
//

import Foundation

final class CleanAppBundle {
    static let shared = CleanAppBundle()
    var bundle = Bundle(for: CleanAppBundle.self)
    private init() { }
}
