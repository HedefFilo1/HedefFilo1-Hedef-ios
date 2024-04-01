//
//  PastMaintenancesViewModel.swift
//  Copilot
//
//  Created by Jamal on 3/28/24.
//

import Foundation

protocol PastMaintenancesVMCrdinatorDelegate: AnyObject {
    func getBack()
    func presentSort(delegate: PastServicesSortViewControllerDelegate)
    func presentFilters(services: [PastService], delegate: PastServicesFilterViewControllerDelegate)
}

protocol PastMaintenancesViewModelDelegate: BaseViewModelDelegate {
    func reloadData()
}

protocol PastMaintenancesViewModelType: AnyObject {
    var coordinatorDelegate: PastMaintenancesVMCrdinatorDelegate? { get set }
    var delegate: PastMaintenancesViewModelDelegate? { get set }
    var items: [PastService]? { get set}
    var type: PastServiceRecordType { get set }
    
    func getBack()
    func getServices()
    func presentFilters()
    func presentSort()
}

class PastMaintenancesViewModel: PastMaintenancesViewModelType {
    
    weak var coordinatorDelegate: PastMaintenancesVMCrdinatorDelegate?
    weak var delegate: PastMaintenancesViewModelDelegate?
    var items: [PastService]?
    var type: PastServiceRecordType = .maintenance
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func getServices() {
        Loading.shared.show(presented: true)
        APIService.getPastServices(type: type.rawValue) { [weak self] model, error in
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
    
    func presentSort() {
        coordinatorDelegate?.presentSort(delegate: self)
    }
    
    func presentFilters() {
        coordinatorDelegate?.presentFilters(services: items ?? [], delegate: self)
    }
}

extension PastMaintenancesViewModel: PastServicesFilterViewControllerDelegate,
                                     PastServicesSortViewControllerDelegate {
    func didTapApply(ascending: Bool) {
        if ascending {
            let sorted = items?.sorted { $0.date ?? Date() < $1.date ?? Date() }
            items = sorted
        } else {
            let sorted = items?.sorted { $0.date ?? Date() > $1.date ?? Date() }
            items = sorted
        }
        
        delegate?.reloadData()
    }
    
    func didTapApply(city: String?, district: String?, date: Date?) {
//        filterCity = city
//        filterDistrict = district
        delegate?.reloadData()
    }
}
