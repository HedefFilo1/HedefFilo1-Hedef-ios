//
//  LastikRandevuConfirmationAcceptionViewController.swift
//  Copilot
//
//  Created by Jamal on 12/25/23.
//

import Foundation

protocol LastikRandevuConfirmationVMCoordinatorDelegate: AnyObject {
    func getBack()
    func lastikFromManger()
}

protocol LastikRandevuConfirmationViewModelDelegate: AnyObject {
    
}

protocol LastikRandevuConfirmationViewModelType: AnyObject {
    var coordinatorDelegate: LastikRandevuConfirmationVMCoordinatorDelegate? { get set }
    var delegate: LastikRandevuConfirmationViewModelDelegate? { get set }
    
    func getBack()
    func lastikFromManger()
}

class LastikRandevuConfirmationViewModel: LastikRandevuConfirmationViewModelType {
    
    weak var coordinatorDelegate: LastikRandevuConfirmationVMCoordinatorDelegate?
    weak var delegate: LastikRandevuConfirmationViewModelDelegate?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func lastikFromManger() {
        coordinatorDelegate?.lastikFromManger()
    }
}
