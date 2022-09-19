//
//  LoagingViewSpy.swift
//  PresentationTests
//
//  Created by Gilberto Silva on 18/09/22.
//

import Foundation
import Presentation

class LoagingViewSpy: LoagingView {
    var emit: ((LoagingViewModel) -> Void)?
    
    func observe(completion: @escaping (LoagingViewModel) -> Void) {
        self.emit = completion
    }
    
    func display(viewModel: LoagingViewModel) {
        self.emit?(viewModel)
    }
}
