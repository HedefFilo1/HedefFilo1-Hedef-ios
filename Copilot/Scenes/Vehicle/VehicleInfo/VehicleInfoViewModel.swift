//
//  VehicleInfoViewModel.swift
//  Copilot
//
//  Created by Jamal on 11/23/23.
//

import Foundation

protocol VehicleInfoViewModelCoordinatorDelegate: AnyObject {
    func goToDocument()
    func goToVehicleGuide()
    
}

protocol VehicleInfoViewModelDelegate: BaseViewModelDelegate {
    func reloadData()
}

protocol VehicleInfoViewModelType: AnyObject {
    var coordinatorDelegate: VehicleInfoViewModelCoordinatorDelegate? { get set }
    var delegate: VehicleInfoViewModelDelegate? { get set }
    var documents: [Document]? { get set }
    func goToDocument()
    func getDocuments()
    func goToVehicleGuide()
}

class VehicleInfoViewModel: VehicleInfoViewModelType {
    
    var coordinatorDelegate: VehicleInfoViewModelCoordinatorDelegate?
    weak var delegate: VehicleInfoViewModelDelegate?
    
    var documents: [Document]?
    
    func goToDocument() {
        coordinatorDelegate?.goToDocument()
    }
    
    func goToVehicleGuide() {
        coordinatorDelegate?.goToVehicleGuide()
    }
    
    func getDocuments() {
        Loading.shared.show()
        APIService.getDocuments { [weak self] model, error in
            Loading.shared.hide()
            guard let self = self else { return }
            
            if let model = model {
                self.documents = model
                self.delegate?.reloadData()
            } else
            
            if let error = error {
                self.delegate?.showError(title: Strings.errorTitle,
                                         message: error.message)
            }
        }
    }
}
