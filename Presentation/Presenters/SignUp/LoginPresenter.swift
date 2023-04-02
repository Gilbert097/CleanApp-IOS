//
//  SignUpPresenter.swift
//  Presentation
//
//  Created by Gilberto Silva on 02/04/22.
//

import Foundation
import Domain

public final class LoginPresenter {
    
    private let validation: Validation
    
    public init(validation: Validation) {
        self.validation = validation
    }
    
    public func login(viewModel: LoginViewModel){
        _ = self.validation.validate(data: viewModel.toJson())
    }
}
