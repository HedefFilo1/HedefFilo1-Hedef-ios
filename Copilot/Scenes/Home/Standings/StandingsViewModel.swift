//
//  StandingsViewModel.swift
//  Copilot
//
//  Created by Jamal on 10/31/23.
//

import Foundation
protocol StandingsViewModelCoordinatorDelegate: AnyObject {
    func getBack()
}

protocol StandingsViewModelDelegate: BaseViewModelDelegate {
    func setTotalPoints()
    func setBarPoints()
}

protocol StandingsViewModelType: AnyObject {
    var delegate: StandingsViewModelDelegate? { get set }
    var totalPoints: Int { get set }
    var barPoints: [BarPoint] { get set }
    func getBack()
    func getTotalPoints() 
}

class StandingsViewModel: StandingsViewModelType {
    
    // MARK: - Delegates
    var coordinatorDelegate: StandingsViewModelCoordinatorDelegate?
    weak var delegate: StandingsViewModelDelegate?
    
    var totalPoints: Int = 0
    var barPoints: [BarPoint] = []
    
    func getBack() {
        coordinatorDelegate?.getBack()
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
                self.getCarPoint()
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
    
}
