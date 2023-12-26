//
//  ServicesViewModel.swift
//  Copilot
//
//  Created by Jamal on 12/26/23.
//

import Foundation

protocol ServicesVMCoordinatorDelegate: AnyObject {

}

protocol ServicesViewModelDelegate: BaseViewModelDelegate {
    func reloadData()
}

protocol ServicesViewModelType: AnyObject {
    var coordinatorDelegate: ServicesVMCoordinatorDelegate? { get set }
    var delegate: ServicesViewModelDelegate? { get set }
    var services: [Supplier]? { get set }
    func getServices()
}

class ServicesViewModel: ServicesViewModelType {
    weak var coordinatorDelegate: ServicesVMCoordinatorDelegate?
    weak var delegate: ServicesViewModelDelegate?
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
