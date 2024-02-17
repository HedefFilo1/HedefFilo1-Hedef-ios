//
//  AccFlw1Stp6ConfirmViewModel.swift
//  Copilot
//
//  Created by Jamal on 2/17/24.
//

import Foundation

protocol AccFlw1Stp6ConfirmVMCrdinatorDlgt: AnyObject {
    func getBack()
}

protocol AccFlw1Stp6ConfirmViewModelDelegate: BaseViewModelDelegate {
    
}

protocol AccFlw1Stp6ConfirmViewModelType: AnyObject {
    var coordinatorDelegate: AccFlw1Stp6ConfirmVMCrdinatorDlgt? { get set }
    var delegate: AccFlw1Stp6ConfirmViewModelDelegate? { get set }
    func getBack()
}

class AccFlw1Stp6ConfirmViewModel: AccFlw1Stp6ConfirmViewModelType {
    
    weak var coordinatorDelegate: AccFlw1Stp6ConfirmVMCrdinatorDlgt?
    weak var delegate: AccFlw1Stp6ConfirmViewModelDelegate?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
}
