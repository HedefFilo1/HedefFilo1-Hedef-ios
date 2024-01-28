//
//  Flow3Step2DamageViewModel.swift
//  Copilot
//
//  Created by Jamal on 1/28/24.
//

import Foundation

protocol Flow3Step2DamageVMCrdintrDelegate: AnyObject {
    func getBack()
    func goToLastikConfirmInfo()
}

protocol Flow3Step2DamageVMDelegate: AnyObject {
    
}

protocol Flow3Step2DamageViewModelType: AnyObject {
    var coordinatorDelegate: Flow3Step2DamageVMCrdintrDelegate? { get set }
    var delegate: Flow3Step2DamageVMDelegate? { get set }
    
    func getBack()
    func goToLastikConfirmInfo()
}

class Flow3Step2DamageViewModel: Flow3Step2DamageViewModelType {
    
    weak var coordinatorDelegate: Flow3Step2DamageVMCrdintrDelegate?
    weak var delegate: Flow3Step2DamageVMDelegate?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func goToLastikConfirmInfo() {
        coordinatorDelegate?.goToLastikConfirmInfo()
    }
}
