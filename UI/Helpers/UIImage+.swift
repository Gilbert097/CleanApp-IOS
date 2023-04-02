//
//  UIViewExtesion.swift
//  UI
//
//  Created by Gilberto Silva on 15/11/22.
//

import Foundation
import UIKit

extension UIImage {
    
    static func image(named: String) -> UIImage {
        UIImage(named: named, in: CleanAppBundle.shared.bundle, compatibleWith: nil) ?? .init()
    }
}
