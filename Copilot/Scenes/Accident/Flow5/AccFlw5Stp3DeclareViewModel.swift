//
//  AccFlw5Stp3DeclareViewModel.swift
//  Copilot
//
//  Created by Jamal on 2/23/24.
//

import Foundation
import PDFKit

protocol AccFlw5Stp3DeclareVMCrdinatorDlgt: AnyObject {
    func getBack()
    func goToAccFlow5Step4()
    func goToGuide()
    func showReportPdf(doc: PDFDocument, title: String)
}

protocol AccFlw5Stp3DeclareViewModelDelegate: BaseViewModelDelegate {
    
}

protocol AccFlw5Stp3DeclareViewModelType: AnyObject {
    var coordinatorDelegate: AccFlw5Stp3DeclareVMCrdinatorDlgt? { get set }
    var delegate: AccFlw5Stp3DeclareViewModelDelegate? { get set }
    func getBack()
    func goToAccFlow5Step4()
    func goToGuide()
    func showExamplePdf()
}

class AccFlw5Stp3DeclareViewModel: AccFlw5Stp3DeclareViewModelType {
    
    weak var coordinatorDelegate: AccFlw5Stp3DeclareVMCrdinatorDlgt?
    weak var delegate: AccFlw5Stp3DeclareViewModelDelegate?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func goToAccFlow5Step4() {
        coordinatorDelegate?.goToAccFlow5Step4()
    }
    
    func goToGuide() {
        coordinatorDelegate?.goToGuide()
    }
    
    func showExamplePdf() {
        if let urlDestination = Bundle.main.url(forResource: "reportExample", withExtension: "pdf") {
            guard let pdf = PDFDocument(url: urlDestination) else { return }
            let title = App.getString(key: "copilotapp.accidentdamage.declaration.form.example.button") ?? ""
            coordinatorDelegate?.showReportPdf(doc: pdf, title: title)
        }
        
    }
}
