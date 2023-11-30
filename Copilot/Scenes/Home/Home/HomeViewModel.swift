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
    func presentKMUsed(delegate: KMUsedViewControllerDelegate)
    func goToSearch()
}

protocol HomeViewModelViewDelegate: AnyObject {
    func setVehicle()
    func setAppointment()
    func showError(title: String, message: String)
    func showSuccess(title: String, message: String)
}

protocol HomeViewModelType: AnyObject {
    var delegate: HomeViewModelViewDelegate? { get set }
    var vehicle: GetVehicle? { get set}
    var appointment: Case? { get set}
    func getVehicle(shoudGetCase: Bool)
    func goToNearMe()
    func goToStandings()
    func presentKMUsed(delegate: KMUsedViewControllerDelegate)
    func goToSearch()
}

class HomeViewModel: HomeViewModelType {
    
    // MARK: - Delegates
    var coordinatorDelegate: HomeViewModelCoordinatorDelegate?
    weak var delegate: HomeViewModelViewDelegate?
    var vehicle: GetVehicle?
    var appointment: Case?
    
    func getVehicle(shoudGetCase: Bool) {
        Loading.shared.show()
        APIService.getVehicle { [weak self] model, error in
            Loading.shared.hide()
            print("yes dis")
            guard let self = self else {return}
            print("yes dis2342342")
            
            if let model = model {
                self.vehicle = model
                self.delegate?.setVehicle()
            } else
            
            if let error = error {
                self.delegate?.showError(title: Strings.errorTitle,
                                         message: error.message)
            }
            if shoudGetCase {
                self.getAppointment()
            }
        }
    }
    
    func getAppointment() {
        Loading.shared.show()
        APIService.getCase { [weak self] model, error in
            Loading.shared.hide()
            guard let self = self else {return}
            
            if let model = model?[0] {
                self.appointment = model
                self.delegate?.setAppointment()
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
    
    func presentKMUsed(delegate: KMUsedViewControllerDelegate) {
        coordinatorDelegate?.presentKMUsed(delegate: delegate)
    }
    
    func goToSearch() {
        coordinatorDelegate?.goToSearch()
    }
}
