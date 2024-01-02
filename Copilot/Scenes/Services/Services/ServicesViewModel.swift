//
//  ServicesViewModel.swift
//  Copilot
//
//  Created by Jamal on 12/26/23.
//

import Foundation

protocol ServicesVMCoordinatorDelegate: AnyObject {
    func presentFilters()
    func getBack()
    func goToServiceDetail(service: Supplier)
}

protocol ServicesViewModelDelegate: BaseViewModelDelegate {
    func reloadData()
}

protocol ServicesViewModelType: AnyObject {
    var coordinatorDelegate: ServicesVMCoordinatorDelegate? { get set }
    var delegate: ServicesViewModelDelegate? { get set }
    var services: [Supplier]? { get set }
    var filteredServices: [Supplier]? { get set }
    var searchText: String { get set }
    func getServices()
    func presentFilters()
    func getBack()
    func goToServiceDetail(service: Supplier)
}

class ServicesViewModel: ServicesViewModelType {
    weak var coordinatorDelegate: ServicesVMCoordinatorDelegate?
    weak var delegate: ServicesViewModelDelegate?
    var services: [Supplier]?
    
    var searchText: String = "" {
        didSet {
            if searchText.count == 0 {
                filteredServices = services
                return
            }
            
            let result = services?.filter {
                $0.name.lowercased().contains(searchText.lowercased())
            }
            
            filteredServices = result
        }
    }
    
    var filteredServices: [Supplier]?
    
    func getServices() {
        let mark = App.vehicle?.make ?? ""
        Loading.shared.show()
        APIService.getSupplier(mark: mark) { [weak self] model, error in
            Loading.shared.hide()
            guard let self = self else { return }
            
            if let model = model {
                self.services = model
                self.filteredServices = model
                self.delegate?.reloadData()
            } else
            
            if let error = error {
                self.delegate?.showError(title: Strings.errorTitle,
                                         message: error.message)
            }
        }
    }
    
    func presentFilters() {
        coordinatorDelegate?.presentFilters()
    }
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func goToServiceDetail(service: Supplier) {
        coordinatorDelegate?.goToServiceDetail(service: service)
    }
}
