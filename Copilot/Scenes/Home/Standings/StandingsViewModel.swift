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

protocol StandingsViewModelDelegate: AnyObject {
    
}

protocol StandingsViewModelType: AnyObject {
    var delegate: StandingsViewModelDelegate? { get set }
    func getBack()
}

class StandingsViewModel: StandingsViewModelType {
    
    // MARK: - Delegates
    var coordinatorDelegate: StandingsViewModelCoordinatorDelegate?
    weak var delegate: StandingsViewModelDelegate?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
}
