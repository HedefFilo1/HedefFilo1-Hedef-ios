//
//  NewLastikRequestViewModel.swift
//  Copilot
//
//  Created by Jamal on 12/25/23.
//

import Foundation

protocol Flow1Step2NewTireVMCoordinatorDelegate: AnyObject {
    func getBack()
    func goToFlow1Step3TireTypes()
}

protocol Flow1Step2NewTireViewModelDelegate: AnyObject {
    
}

protocol Flow1Step2NewTireViewModelType: AnyObject {
    var coordinatorDelegate: Flow1Step2NewTireVMCoordinatorDelegate? { get set }
    var delegate: Flow1Step2NewTireViewModelDelegate? { get set }
    
    func getBack()
    func lastikFromManger()
}

class Flow1Step2NewTireViewModel: Flow1Step2NewTireViewModelType {
    
    weak var coordinatorDelegate: Flow1Step2NewTireVMCoordinatorDelegate?
    weak var delegate: Flow1Step2NewTireViewModelDelegate?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func lastikFromManger() {
        coordinatorDelegate?.goToFlow1Step3TireTypes()
    }
}
