//
//  ContractAgreementViewModel.swift
//  Copilot
//
//  Created by Jamal on 3/12/24.
//

import Foundation

protocol ContractAgreementVMCrdinatorDelegate: AnyObject {
    func getBack()
}

protocol ContractAgreementViewModelDelegate: BaseViewModelDelegate {
    
}

protocol ContractAgreementViewModelType: AnyObject {
    var coordinatorDelegate: ContractAgreementVMCrdinatorDelegate? { get set }
    var delegate: ContractAgreementViewModelDelegate? { get set }
    func getBack()
}

class ContractAgreementViewModel: ContractAgreementViewModelType {
    
    weak var coordinatorDelegate: ContractAgreementVMCrdinatorDelegate?
    weak var delegate: ContractAgreementViewModelDelegate?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
}
