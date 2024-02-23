//
//  AccFlw4Stp4NoAgreementReportViewModel.swift
//  Copilot
//
//  Created by Jamal on 2/22/24.
//

import Foundation

protocol AccFlw4Stp4NoAgreementReportVMCrdntrDlgt: AnyObject {
    func getBack()
    func goToFlow4Step5()
}

protocol AccFlw4Stp4NoAgreementReportVMDelegate: BaseViewModelDelegate {
    
}

protocol AccFlw4Stp4NoAgreementReportVModelType: AnyObject {
    var coordinatorDelegate: AccFlw4Stp4NoAgreementReportVMCrdntrDlgt? { get set }
    var delegate: AccFlw4Stp4NoAgreementReportVMDelegate? { get set }
    func getBack()
    func goToFlow4Step5()
}

class AccFlw4Stp4NoAgreementReportViewModel: AccFlw4Stp4NoAgreementReportVModelType {
    
    weak var coordinatorDelegate: AccFlw4Stp4NoAgreementReportVMCrdntrDlgt?
    weak var delegate: AccFlw4Stp4NoAgreementReportVMDelegate?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }

    func goToFlow4Step5() {
        coordinatorDelegate?.goToFlow4Step5()
    }
}
