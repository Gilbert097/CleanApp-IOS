//
//  MyTextField.swift
//  UI
//
//  Created by Gilberto Silva on 14/03/23.
//

import Foundation
import UIKit

public class HighlightedTextField: UITextField {
    
    public init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.font = UIFont.systemFont(ofSize: 14)
        self.borderStyle = UITextField.BorderStyle.roundedRect
        self.autocorrectionType = UITextAutocorrectionType.no
        self.keyboardType = UIKeyboardType.default
        self.returnKeyType = UIReturnKeyType.done
        self.clearButtonMode = UITextField.ViewMode.whileEditing
        self.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        self.layer.borderColor = Color.primaryLight.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 5
    }
}
