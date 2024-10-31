//
//  PastMaintenancesViewModel.swift
//  Copilot
//
//  Created by Jamal on 3/28/24.
//

import Foundation

protocol PastMaintenancesVMCrdinatorDelegate: AnyObject {
    func getBack()
    func presentSort(delegate: SortViewControllerDelegate)
    func presentFilters(services: [PastService], delegate: PastServicesFilterViewControllerDelegate)
    func goToPastServiceDetail(service: PastService, title: String)
}

protocol PastMaintenancesViewModelDelegate: BaseViewModelDelegate {
    func reloadData()
}

protocol PastMaintenancesViewModelType: AnyObject {
    var coordinatorDelegate: PastMaintenancesVMCrdinatorDelegate? { get set }
    var delegate: PastMaintenancesViewModelDelegate? { get set }
    var items: [PastService]? { get set}
    var type: PastServiceRecordType { get set }
    var tab: Int { get }
    
    func getBack()
    func getServices()
    func presentFilters()
    func presentSort()
    func goToPastServiceDetail(service: PastService, title: String)
}

class PastMaintenancesViewModel: PastMaintenancesViewModelType {
    
    weak var coordinatorDelegate: PastMaintenancesVMCrdinatorDelegate?
    weak var delegate: PastMaintenancesViewModelDelegate?
    var items: [PastService]?
    var type: PastServiceRecordType = .maintenance
    
    var filterCity: String?
    var filterDistrict: String?
    var filterDate: Date?
    var searchText: String = ""
    
    var filteredServices: [PastService]? {
        var result = items
        if let city = filterCity {
            result = result?.filter({ $0.city == city })
        }
        
        if let district = filterDistrict {
            result = result?.filter({ $0.district == district })
        }
        
        if let date = filterDate {
            result = result?.filter({ $0.date == date })
        }
        
        if searchText.count == 0 {
            return result
        }
        
        let result2 = result?.filter {
            $0.serviceName?.lowercased().contains(searchText.lowercased()) ?? false
        }
        
        return result2
    }
    
    var tab: Int {
        switch type {
        case .maintenance:
            return 0
        case .tireChange:
            return 2
        case .mechanicalFailure:
            return 1
        case .damage:
            return 3
        case .none:
            return 0
        }
    }
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func getServices() {
        Loading.shared.show(presented: true)
        var value = ""
        switch type {
        case .maintenance:
             value = "MAINTENANCE"
        case .tireChange:
            value = "TIRE"
        case .mechanicalFailure:
            value = "FAILURE"
        case .damage:
            value = "DAMAGE"
        case .none:
            value = ""
        }
        filterCity = nil
        filterDistrict = nil
        filterDate = nil
        searchText = ""
        APIService.getPastServices(type: value) { [weak self] model, error in
            Loading.shared.hide()
            guard let self = self else { return }
            
            if let error = error {
                self.delegate?.showError(title: Strings.errorTitle,
                                         message: error.message)
            }
            if let model {
                self.items = model
                self.didTapApply(ascending: false)
//                self.delegate?.reloadData()
            }
        }
    }
    
    func presentSort() {
        coordinatorDelegate?.presentSort(delegate: self)
    }
    
    func presentFilters() {
        coordinatorDelegate?.presentFilters(services: items ?? [], delegate: self)
    }
    
    func goToPastServiceDetail(service: PastService, title: String) {
        coordinatorDelegate?.goToPastServiceDetail(service: service, title: title)
    }
}

extension PastMaintenancesViewModel: PastServicesFilterViewControllerDelegate,
                                     SortViewControllerDelegate {
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
        filterCity = city
        filterDistrict = district
        filterDate = date
        delegate?.reloadData()
    }
}
