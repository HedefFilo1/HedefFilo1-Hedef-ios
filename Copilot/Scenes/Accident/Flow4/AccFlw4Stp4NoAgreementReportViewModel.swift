//
//  AccFlw4Stp4NoAgreementReportViewModel.swift
//  Copilot
//
//  Created by Jamal on 2/22/24.
//

import Foundation

protocol AccFlw4Stp4NoAgreementReportVMCrdinatorDlgt: AnyObject {
    func getBack()
}

protocol AccFlw4Stp4NoAgreementReportViewModelDelegate: BaseViewModelDelegate {
    
}

protocol AccFlw4Stp4NoAgreementReportViewModelType: AnyObject {
    var coordinatorDelegate: AccFlw4Stp4NoAgreementReportVMCrdinatorDlgt? { get set }
    var delegate: AccFlw4Stp4NoAgreementReportViewModelDelegate? { get set }
    func getBack()
    
}

class AccFlw4Stp4NoAgreementReportViewModel: AccFlw4Stp4NoAgreementReportViewModelType {
    
    weak var coordinatorDelegate: AccFlw4Stp4NoAgreementReportVMCrdinatorDlgt?
    weak var delegate: AccFlw4Stp4NoAgreementReportViewModelDelegate?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }

}
