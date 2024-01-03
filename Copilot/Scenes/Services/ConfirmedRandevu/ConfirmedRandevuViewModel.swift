//
//  ConfirmedRandevuViewModel.swift
//  Copilot
//
//  Created by Jamal on 1/3/24.
//

import Foundation

protocol ConfirmedRandevuVMCoordinatorDelegate: AnyObject {
    func getBack()
    func getBackToHome()
}

protocol ConfirmedRandevuViewModelDelegate: BaseViewModelDelegate {
    
}

protocol ConfirmedRandevuViewModelType: AnyObject {
    var coordinatorDelegate: ConfirmedRandevuVMCoordinatorDelegate? { get set }
    var delegate: ConfirmedRandevuViewModelDelegate? { get set }
    var randevu: MockRandevu? { get set }
    func getBack()
    func getBackToHome()
}

class ConfirmedRandevuViewModel: ConfirmedRandevuViewModelType {
    weak var coordinatorDelegate: ConfirmedRandevuVMCoordinatorDelegate?
    weak var delegate: ConfirmedRandevuViewModelDelegate?
    
    var randevu: MockRandevu?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func getBackToHome() {
        coordinatorDelegate?.getBackToHome()
    }
}
