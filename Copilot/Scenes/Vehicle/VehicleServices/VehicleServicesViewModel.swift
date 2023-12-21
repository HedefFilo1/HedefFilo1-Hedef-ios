//
//  ServicesViewModel.swift
//  Copilot
//
//  Created by Jamal on 12/19/23.
//

import Foundation

protocol VehicleServicesVMCoordinatorDelegate: AnyObject {

}

protocol VehicleServicesViewModelDelegate: BaseViewModelDelegate {
    func reloadData()
}

protocol VehicleServicesViewModelType: AnyObject {
    var coordinatorDelegate: VehicleServicesVMCoordinatorDelegate? { get set }
    var delegate: VehicleServicesViewModelDelegate? { get set }
    var services: [Supplier]? { get set }
    func getServices()
}

class VehicleServicesViewModel: VehicleServicesViewModelType {
    weak var coordinatorDelegate: VehicleServicesVMCoordinatorDelegate?
    weak var delegate: VehicleServicesViewModelDelegate?
    var services: [Supplier]?
    
    func getServices() {
        let mark = App.vehicle?.make ?? ""
        Loading.shared.show()
        APIService.getSupplier(mark: mark) { [weak self] model, error in
            Loading.shared.hide()
            guard let self = self else { return }
            
            if let model = model {
                self.services = model
                self.delegate?.reloadData()
            } else
            
            if let error = error {
                self.delegate?.showError(title: Strings.errorTitle,
                                         message: error.message)
            }
        }
    }
}
