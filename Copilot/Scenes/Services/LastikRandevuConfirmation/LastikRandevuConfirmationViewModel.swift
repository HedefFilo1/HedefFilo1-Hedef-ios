//
//  LastikRandevuConfirmationAcceptionViewController.swift
//  Copilot
//
//  Created by Jamal on 12/25/23.
//

import Foundation

protocol LastikRandevuConfirmationVMCrdintrDlgt: AnyObject {
    func getBack()
    func goToLastikConfirmInfo()
}

protocol LastikRandevuConfirmationVMDelegate: AnyObject {
    
}

protocol LastikRandevuConfirmationViewModelType: AnyObject {
    var coordinatorDelegate: LastikRandevuConfirmationVMCrdintrDlgt? { get set }
    var delegate: LastikRandevuConfirmationVMDelegate? { get set }
    
    func getBack()
    func goToLastikConfirmInfo()
}

class LastikRandevuConfirmationViewModel: LastikRandevuConfirmationViewModelType {
    
    weak var coordinatorDelegate: LastikRandevuConfirmationVMCrdintrDlgt?
    weak var delegate: LastikRandevuConfirmationVMDelegate?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func goToLastikConfirmInfo() {
        coordinatorDelegate?.goToLastikConfirmInfo()
    }
}
