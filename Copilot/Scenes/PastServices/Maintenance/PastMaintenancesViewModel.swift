//
//  PastMaintenancesViewModel.swift
//  Copilot
//
//  Created by Jamal on 3/28/24.
//

import Foundation

protocol PastMaintenancesVMCrdinatorDelegate: AnyObject {
    func getBack()
    func presentFilters(services: [PastService], delegate: PastServicesFilterViewControllerDelegate)
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
    func presentFilters()
}

class PastMaintenancesViewModel: PastMaintenancesViewModelType {
    
    weak var coordinatorDelegate: PastMaintenancesVMCrdinatorDelegate?
    weak var delegate: PastMaintenancesViewModelDelegate?
    var items: [PastService]?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func getServices() {
        Loading.shared.show(presented: true)
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
    
    func presentFilters() {
        coordinatorDelegate?.presentFilters(services: items ?? [], delegate: self)
    }
}

extension PastMaintenancesViewModel: PastServicesFilterViewControllerDelegate {
    func didTapApply(city: String?, district: String?, date: Date?) {
//        filterCity = city
//        filterDistrict = district
        delegate?.reloadData()
    }
}
