//
//  AccFlw1Stp4ReportViewModel.swift
//  Copilot
//
//  Created by Jamal on 2/16/24.
//

import Foundation
import PDFKit

protocol AccFlw1Stp4ReportVMCrdinatorDlgt: AnyObject {
    func getBack()
    func goToAccFlw1Stp5Leaks()
    func goToGuide()
    func showReportPdf(doc: PDFDocument, title: String)
}

protocol AccFlw1Stp4ReportViewModelDelegate: BaseViewModelDelegate {
    
}

protocol AccFlw1Stp4ReportViewModelType: AnyObject {
    var coordinatorDelegate: AccFlw1Stp4ReportVMCrdinatorDlgt? { get set }
    var delegate: AccFlw1Stp4ReportViewModelDelegate? { get set }
    func getBack()
    func goToAccFlw1Stp5Leaks()
    func goToGuide()
    func showReportPdf()
}

class AccFlw1Stp4ReportViewModel: AccFlw1Stp4ReportViewModelType {
    
    weak var coordinatorDelegate: AccFlw1Stp4ReportVMCrdinatorDlgt?
    weak var delegate: AccFlw1Stp4ReportViewModelDelegate?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func goToAccFlw1Stp5Leaks() {
        coordinatorDelegate?.goToAccFlw1Stp5Leaks()
    }
    
    func goToGuide() {
        coordinatorDelegate?.goToGuide()
    }
    
    func showReportPdf() {
        if let urlDestination = Bundle.main.url(forResource: "samplePdfFile", withExtension: "pdf") {
            guard let pdf = PDFDocument(url: urlDestination) else { return }
            let title = App.getString(key: "copilotapp.accidentdamage.accident.process.record.keeping.sample.minute") ?? ""
            coordinatorDelegate?.showReportPdf(doc: pdf, title: title)
        }
        
    }
    
}
