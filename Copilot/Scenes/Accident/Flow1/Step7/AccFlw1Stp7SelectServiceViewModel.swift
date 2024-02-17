//
//  AccFlw1Stp7SelectServiceViewModel.swift
//  Copilot
//
//  Created by Jamal on 2/17/24.
//

import Foundation

protocol AccFlw1Stp7SelectServiceVMCrdinatorDlgt: AnyObject {
    func getBack()
}

protocol AccFlw1Stp7SelectServiceVMDelegate: BaseViewModelDelegate {
    
}

protocol AccFlw1Stp7SelectServiceViewModelType: AnyObject {
    var coordinatorDelegate: AccFlw1Stp7SelectServiceVMCrdinatorDlgt? { get set }
    var delegate: AccFlw1Stp7SelectServiceVMDelegate? { get set }
    func getBack()
}

class AccFlw1Stp7SelectServiceViewModel: AccFlw1Stp7SelectServiceViewModelType {
    
    weak var coordinatorDelegate: AccFlw1Stp7SelectServiceVMCrdinatorDlgt?
    weak var delegate: AccFlw1Stp7SelectServiceVMDelegate?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
}
