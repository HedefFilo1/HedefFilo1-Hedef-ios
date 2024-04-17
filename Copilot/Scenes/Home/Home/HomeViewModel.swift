//
//  HomeViewModel.swift
//  Copilot
//
//  Created by Jamal on 10/10/23.
//

import Foundation

protocol HomeViewModelCoordinatorDelegate: AnyObject {
    func goToNearMe(mark: String)
    func goToStandings()
    func presentKMUsed(delegate: KMUsedViewControllerDelegate)
    func goToSearch()
}

protocol HomeViewModelViewDelegate: AnyObject {
    func setVehicle()
    func setAppointment()
    func setTire()
    func setLastMaintenance()
    func showError(title: String, message: String)
    func showSuccess(title: String, message: String)
    func setTotalPoints()
    func setBarPoints()
}

protocol HomeViewModelType: AnyObject {
    var delegate: HomeViewModelViewDelegate? { get set }
    var coordinatorDelegate: HomeViewModelCoordinatorDelegate? { get set }
    var vehicle: Vehicle? { get set}
    var appointment: Case? { get set}
    var tire: Tire? { get set }
    var last: MaintenanceLast? { get set }
    var totalPoints: Int { get set }
    var barPoints: [BarPoint] { get set }
    func getVehicle(shoudGetCase: Bool)
    func goToNearMe()
    func goToStandings()
    func presentKMUsed(delegate: KMUsedViewControllerDelegate)
    func goToSearch()
    func getAppointment()
}

class HomeViewModel: HomeViewModelType {
    
    // MARK: - Delegates
    weak var coordinatorDelegate: HomeViewModelCoordinatorDelegate?
    weak var delegate: HomeViewModelViewDelegate?
    var vehicle: Vehicle?
    var appointment: Case?
    var tire: Tire?
    var last: MaintenanceLast?
    var mark: String = ""
    var totalPoints: Int = 0
    var barPoints: [BarPoint] = []
    
    func getVehicle(shoudGetCase: Bool) {
        Loading.shared.show()
        APIService.getVehicle { [weak self] model, error in
            Loading.shared.hide()
            guard let self = self else { return }
            
            if let model = model {
                self.vehicle = model
                App.vehicle = model
                self.mark = model.make
                self.delegate?.setVehicle()
                APIService.addUserAction(pageName: "HOMEPAGE", actionName: "HOMEPAGE_LOAD")
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
        APIService.getHomeCase { [weak self] model, error in
            Loading.shared.hide()
            guard let self = self else { return }
            
            if let model = model, model.count > 0 {
//                self.appointment = model[0]
                let next10 = Calendar.current.date(byAdding: .day, value: 10, to: Date()) ?? Date()
                
                for item in model where (item.appointmentDate != nil) {
                    let itemDate = item.date ?? Date()
                    
                    if self.appointment == nil, itemDate < next10 {
                        self.appointment = item
                        
                    } else if let appointment = self.appointment, let current = appointment.date {
                        if let date = item.date, date < current {
                            self.appointment = item
                        }
                    }
                }
                self.delegate?.setAppointment()
                
            } else
            
            if let error = error {
                self.delegate?.showError(title: Strings.errorTitle,
                                         message: error.message)
            }
            self.getTire()
        }
    }
    
    func getTire() {
        Loading.shared.show()
        APIService.getTire { [weak self] model, _ in
            Loading.shared.hide()
            guard let self = self else { return }
            
            if let model = model, model.count > 0 {
                self.tire = model[0]
                self.delegate?.setTire()
            }
            
            self.getLastMaintenance()
        }
    }
    
    func getLastMaintenance() {
        Loading.shared.show()
        APIService.getLastMaintenance { [weak self] model, _ in
            Loading.shared.hide()
            guard let self = self else { return }
            if let model = model {
                self.last = model
                self.delegate?.setLastMaintenance()
                self.getTotalPoints()
            }
        }
    }
    
    func getTotalPoints() {
        Loading.shared.show()
        APIService.getTotalPoints { [weak self] model, error in
            Loading.shared.hide()
            guard let self = self else { return }
            
            if let model = model {
                self.totalPoints = model.totalPoints
                self.delegate?.setTotalPoints()
                self.getBarPoints()
            } else
            
            if let error = error {
                self.delegate?.showError(title: Strings.errorTitle,
                                         message: error.message)
            }
        }
    }
    
    func getBarPoints() {
        Loading.shared.show()
        APIService.getBarPoints { [weak self] model, error in
            Loading.shared.hide()
            guard let self = self else { return }
            
            if let model = model {
                self.barPoints = model
                self.delegate?.setBarPoints()
//                self.getCarPoint()
            } else
            
            if let error = error {
                self.delegate?.showError(title: Strings.errorTitle,
                                         message: error.message)
            }
        }
    }
    
    func getCarPoint() {
        Loading.shared.show()
        APIService.getCarPoint { [weak self] model, error in
            Loading.shared.hide()
            guard let self = self else { return }
            
            if let model = model {
                self.barPoints = model
                self.delegate?.setBarPoints()
            } else
            
            if let error = error {
                self.delegate?.showError(title: Strings.errorTitle,
                                         message: error.message)
            }
        }
    }
    
    func goToNearMe() {
        coordinatorDelegate?.goToNearMe(mark: mark)
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
