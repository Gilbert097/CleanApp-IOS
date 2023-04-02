//
//  UIViewExtesion.swift
//  UI
//
//  Created by Gilberto Silva on 15/11/22.
//

import Foundation
import UIKit

extension UIView {
    
    func addSubviews(_ views: [UIView]) {
        views.forEach { view in
            addSubview(view)
        }
    }
}
