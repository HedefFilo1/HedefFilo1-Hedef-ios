//
//  Flow3Step3ConfirmAcceptionViewController.swift
//  Copilot
//
//  Created by Jamal on 12/25/23.
//

import Foundation

protocol Flow3Step3ConfirmVMCrdintrDelegate: AnyObject {
    func getBack()
    func goToFlow3Step4TowTruck()
}

protocol Flow3Step3ConfirmVMDelegate: AnyObject {
    
}

protocol Flow3Step3ConfirmViewModelType: AnyObject {
    var coordinatorDelegate: Flow3Step3ConfirmVMCrdintrDelegate? { get set }
    var delegate: Flow3Step3ConfirmVMDelegate? { get set }
    
    func getBack()
    func goToFlow3Step4TowTruck()
}

class Flow3Step3ConfirmViewModel: Flow3Step3ConfirmViewModelType {
    
    weak var coordinatorDelegate: Flow3Step3ConfirmVMCrdintrDelegate?
    weak var delegate: Flow3Step3ConfirmVMDelegate?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func goToFlow3Step4TowTruck() {
        coordinatorDelegate?.goToFlow3Step4TowTruck()
    }
}
