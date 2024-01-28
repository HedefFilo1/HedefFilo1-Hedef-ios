//
//  Flow3Step3ConfirmAcceptionViewController.swift
//  Copilot
//
//  Created by Jamal on 12/25/23.
//

import Foundation

protocol Flow3Step3ConfirmVMCrdintrDlgt: AnyObject {
    func getBack()
    func goToLastikConfirmInfo()
}

protocol Flow3Step3ConfirmVMDelegate: AnyObject {
    
}

protocol Flow3Step3ConfirmViewModelType: AnyObject {
    var coordinatorDelegate: Flow3Step3ConfirmVMCrdintrDlgt? { get set }
    var delegate: Flow3Step3ConfirmVMDelegate? { get set }
    
    func getBack()
    func goToLastikConfirmInfo()
}

class Flow3Step3ConfirmViewModel: Flow3Step3ConfirmViewModelType {
    
    weak var coordinatorDelegate: Flow3Step3ConfirmVMCrdintrDlgt?
    weak var delegate: Flow3Step3ConfirmVMDelegate?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func goToLastikConfirmInfo() {
        coordinatorDelegate?.goToLastikConfirmInfo()
    }
}
