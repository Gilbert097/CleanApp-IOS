//
//  MyTextField.swift
//  UI
//
//  Created by Gilberto Silva on 14/03/23.
//

import Foundation
import UIKit

public class PrimaryButton: UIButton {
    private let title: String
    private let color: UIColor
    private let textColor: UIColor
    
    public init(title: String,
                color: UIColor = Color.primary,
                textColor: UIColor = .white) {
        self.title = title
        self.color = color
        self.textColor = textColor
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.clipsToBounds = true
        self.layer.cornerRadius = 5
        self.contentHorizontalAlignment = .center
        
        
        if #available(iOS 15.0, *) {
            var config = UIButton.Configuration.filled()
            var container = AttributeContainer()
            container.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            config.attributedTitle = AttributedString(self.title, attributes: container)
            config.baseBackgroundColor = self.color
            config.baseForegroundColor = self.textColor
            self.configuration = config
        } else {
            self.setTitleColor(self.textColor, for: .normal)
            self.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            self.backgroundColor = self.color
            self.setTitle(self.title, for: .normal)
        }
    }
}
