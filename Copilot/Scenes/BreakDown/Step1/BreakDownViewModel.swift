//
//  BreakDownViewModel.swift
//  Copilot
//
//  Created by Jamal on 1/31/24.
//

import Foundation

protocol BreakDownVMCoordinatorDelegate: AnyObject {
    func getBack()
    func goToFlow1BreakDownStep2TowTruck()
    func goToBreakdownFlow2Step2AnyAlarm()
}

protocol BreakDownViewModelDelegate: BaseViewModelDelegate {
    func setBreakDown()
}

protocol BreakDownViewModelType: AnyObject {
    var coordinatorDelegate: BreakDownVMCoordinatorDelegate? { get set }
    var delegate: BreakDownViewModelDelegate? { get set }
    var appointment: Case? { get set }
    func getBack()
    func goToFlow1BreakDownStep2TowTruck()
    func goToBreakdownFlow2Step2AnyAlarm()
}

class BreakDownViewModel: BreakDownViewModelType {
    
    weak var coordinatorDelegate: BreakDownVMCoordinatorDelegate?
    weak var delegate: BreakDownViewModelDelegate?
    var appointment: Case?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func goToFlow1BreakDownStep2TowTruck() {
        coordinatorDelegate?.goToFlow1BreakDownStep2TowTruck()
    }
    
    func goToBreakdownFlow2Step2AnyAlarm() {
        coordinatorDelegate?.goToBreakdownFlow2Step2AnyAlarm()
    }
    
}
