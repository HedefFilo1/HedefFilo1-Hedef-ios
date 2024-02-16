//
//  AccFlw1Stp3AgreementViewModel.swift
//  Copilot
//
//  Created by Jamal on 2/16/24.
//

import Foundation

protocol AccFlw1Stp3AgreementVMCrdinatorDlgt: AnyObject {
    func getBack()
}

protocol AccFlw1Stp3AgreementViewModelDelegate: BaseViewModelDelegate {
    
}

protocol AccFlw1Stp3AgreementViewModelType: AnyObject {
    var coordinatorDelegate: AccFlw1Stp3AgreementVMCrdinatorDlgt? { get set }
    var delegate: AccFlw1Stp3AgreementViewModelDelegate? { get set }
    func getBack()
}

class AccFlw1Stp3AgreementViewModel: AccFlw1Stp3AgreementViewModelType {
    
    weak var coordinatorDelegate: AccFlw1Stp3AgreementVMCrdinatorDlgt?
    weak var delegate: AccFlw1Stp3AgreementViewModelDelegate?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
}
