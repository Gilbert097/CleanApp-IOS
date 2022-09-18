//
//  LoagingView.swift
//  Presentation
//
//  Created by Gilberto Silva on 18/09/22.
//

import Foundation

public protocol LoagingView {
    func display(viewModel: LoagingViewModel)
}

public struct LoagingViewModel: Equatable {
    public var isLoading: Bool
    
    public init(isLoading: Bool) {
        self.isLoading = isLoading
    }
}
