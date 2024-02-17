//
//  AccFlw1Stp5LeaksViewModel.swift
//  Copilot
//
//  Created by Jamal on 2/16/24.
//

import Foundation

protocol AccFlw1Stp5LeaksVMCrdinatorDlgt: AnyObject {
    func getBack()
    func goToAccFlw1Stp6Confirm()
}

protocol AccFlw1Stp5LeaksViewModelDelegate: BaseViewModelDelegate {
    
}

protocol AccFlw1Stp5LeaksViewModelType: AnyObject {
    var coordinatorDelegate: AccFlw1Stp5LeaksVMCrdinatorDlgt? { get set }
    var delegate: AccFlw1Stp5LeaksViewModelDelegate? { get set }
    func getBack()
    func goToAccFlw1Stp6Confirm()
}

class AccFlw1Stp5LeaksViewModel: AccFlw1Stp5LeaksViewModelType {
    
    weak var coordinatorDelegate: AccFlw1Stp5LeaksVMCrdinatorDlgt?
    weak var delegate: AccFlw1Stp5LeaksViewModelDelegate?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func goToAccFlw1Stp6Confirm() {
        coordinatorDelegate?.goToAccFlw1Stp6Confirm()
    }
    
}
