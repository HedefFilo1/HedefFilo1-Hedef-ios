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
    func showSuccess(title: String, message: String)
    func showError(title: String, message: String)
}

protocol KMUsedViewModelType: AnyObject {
    var delegate: KMUsedViewModelDelegate? { get set }
    var distance: Double { get set }
    func setDistance(distance: Double)
    func dismiss()
}

class KMUsedViewModel: KMUsedViewModelType {
    
    // MARK: - Delegates
    var coordinatorDelegate: KMUsedViewModelCoordinatorDelegate?
    weak var delegate: KMUsedViewModelDelegate?
    var distance: Double = 0
    
    func setDistance(distance: Double) {
        APIService.setVehicleDistance(distance: distance) { [weak self] _, error in
            
            Loading.shared.hide()
            guard let self = self else { return }
            
            if let error = error {
                self.delegate?.showError(title: Strings.errorTitle, message: error.message)
                return
            }
            self.coordinatorDelegate?.dismiss(self)
        }
    }
    
    func dismiss() {
        coordinatorDelegate?.dismiss(self)
    }
    
}
