//
//  KMUsedViewModel.swift
//  Copilot
//
//  Created by Jamal on 10/31/23.
//

import Foundation
protocol KMUsedViewModelCoordinatorDelegate: AnyObject {
    func dismiss(_: KMUsedViewModelType)
}

protocol KMUsedViewModelDelegate: AnyObject {
    
}

protocol KMUsedViewModelType: AnyObject {
    var delegate: KMUsedViewModelDelegate? { get set }
    func dismiss()
}

class KMUsedViewModel: KMUsedViewModelType {
    
    // MARK: - Delegates
    var coordinatorDelegate: KMUsedViewModelCoordinatorDelegate?
    weak var delegate: KMUsedViewModelDelegate?
    
    func dismiss() {
        coordinatorDelegate?.dismiss(self)
    }
    
}
