//
//  PastMaintenancesViewModel.swift
//  Copilot
//
//  Created by Jamal on 3/28/24.
//

import Foundation

protocol PastMaintenancesVMCrdinatorDelegate: AnyObject {
    func getBack()
}

protocol PastMaintenancesViewModelDelegate: BaseViewModelDelegate {
    func reloadData()
}

protocol PastMaintenancesViewModelType: AnyObject {
    var coordinatorDelegate: PastMaintenancesVMCrdinatorDelegate? { get set }
    var delegate: PastMaintenancesViewModelDelegate? { get set }
    var items: [PastService]? { get set}
    
    func getBack()
    func getServices()
}

class PastMaintenancesViewModel: PastMaintenancesViewModelType {
    
    weak var coordinatorDelegate: PastMaintenancesVMCrdinatorDelegate?
    weak var delegate: PastMaintenancesViewModelDelegate?
    var items: [PastService]?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func getServices() {
        Loading.shared.show()
        APIService.getPastMaintenaces { [weak self] model, error in
            Loading.shared.hide()
            guard let self = self else { return }
            
            if let error = error {
                self.delegate?.showError(title: Strings.errorTitle,
                                         message: error.message)
            }
            if let model {
                self.items = model
                self.delegate?.reloadData()
            }
        }
    }
}
