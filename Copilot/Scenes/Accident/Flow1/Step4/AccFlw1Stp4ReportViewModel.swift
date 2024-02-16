//
//  AccFlw1Stp4ReportViewModel.swift
//  Copilot
//
//  Created by Jamal on 2/16/24.
//

import Foundation

protocol AccFlw1Stp4ReportVMCrdinatorDlgt: AnyObject {
    func getBack()
    func goToAccFlw1Stp3Leaks()
}

protocol AccFlw1Stp4ReportViewModelDelegate: BaseViewModelDelegate {
    
}

protocol AccFlw1Stp4ReportViewModelType: AnyObject {
    var coordinatorDelegate: AccFlw1Stp4ReportVMCrdinatorDlgt? { get set }
    var delegate: AccFlw1Stp4ReportViewModelDelegate? { get set }
    func getBack()
    func goToAccFlw1Stp3Leaks()
}

class AccFlw1Stp4ReportViewModel: AccFlw1Stp4ReportViewModelType {
    
    weak var coordinatorDelegate: AccFlw1Stp4ReportVMCrdinatorDlgt?
    weak var delegate: AccFlw1Stp4ReportViewModelDelegate?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func goToAccFlw1Stp3Leaks() {
        coordinatorDelegate?.goToAccFlw1Stp3Leaks()
    }
    
}
