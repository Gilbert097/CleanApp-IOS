//
//  WeakVarProxy.swift
//  Main
//
//  Created by Gilberto Silva on 21/03/23.
//

import Foundation
import Presentation

public final class WeakVarProxy<T: AnyObject> {
   
    private weak var instance: T?
    
    init(_ instance: T?) {
        self.instance = instance
    }
}

extension WeakVarProxy: AlertView where T: AlertView {
    
    public func showMessage(viewModel: Presentation.AlertViewModel) {
        self.instance?.showMessage(viewModel: viewModel)
    }
}

extension WeakVarProxy: LoagingView where T: LoagingView {
    
    public func display(viewModel: Presentation.LoagingViewModel) {
        self.instance?.display(viewModel: viewModel)
    }
}
