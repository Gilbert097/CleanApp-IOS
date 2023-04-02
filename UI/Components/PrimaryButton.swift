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
    
    public init(title: String) {
        self.title = title
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
            config.baseBackgroundColor = Color.primary
            self.configuration = config
        } else {
            self.setTitleColor(.white, for: .normal)
            self.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            self.backgroundColor = Color.primary
            self.setTitle(self.title, for: .normal)
        }
    }
}
