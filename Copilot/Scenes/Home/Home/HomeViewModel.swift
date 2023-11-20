//
//  HomeViewModel.swift
//  Copilot
//
//  Created by Jamal on 10/10/23.
//

import Foundation

protocol HomeViewModelCoordinatorDelegate: AnyObject {
    func goToNearMe()
    func goToStandings()
    func presentKMUsed()
    func goToSearch()
}

protocol HomeViewModelViewDelegate: AnyObject {
    func setVehicle()
    func showError(title: String, message: String)
    func showSuccess(title: String, message: String)
}

protocol HomeViewModelType: AnyObject {
    var delegate: HomeViewModelViewDelegate? { get set }
    var vehicle: GetVehicle? { get set}
    func getVehicle()
    func goToNearMe()
    func goToStandings()
    func presentKMUsed()
    func goToSearch()
}

class HomeViewModel: HomeViewModelType {
    
    // MARK: - Delegates
    var coordinatorDelegate: HomeViewModelCoordinatorDelegate?
    weak var delegate: HomeViewModelViewDelegate?
    var vehicle: GetVehicle?
    
    func getVehicle() {
        Loading.shared.show()
        APIService.getVehicle { [weak self] model, error in
            Loading.shared.hide()
            guard let self = self else {return}
            
            if let model = model {
                self.vehicle = model
                self.delegate?.setVehicle()
            } else
            
            if let error = error {
                self.delegate?.showError(title: Strings.errorTitle,
                                         message: error.message)
                return
            }
        }
    }
    
    func goToNearMe() {
        coordinatorDelegate?.goToNearMe()
    }
    
    func goToStandings() {
        coordinatorDelegate?.goToStandings()
    }
    
    func presentKMUsed() {
        coordinatorDelegate?.presentKMUsed()
    }
    
    func goToSearch() {
        coordinatorDelegate?.goToSearch()
    }
}
