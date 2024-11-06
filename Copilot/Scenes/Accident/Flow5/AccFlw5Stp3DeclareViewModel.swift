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
    func reloadData()
}

protocol AccFlw5Stp3DeclareViewModelType: AnyObject {
    var coordinatorDelegate: AccFlw5Stp3DeclareVMCrdinatorDlgt? { get set }
    var delegate: AccFlw5Stp3DeclareViewModelDelegate? { get set }
    var selectedFiles: [FileInfo] { get set }
    func getBack()
    func sendFile(image: UIImage)
    func goToAccFlow5Step4()
    func goToGuide()
    func showExamplePdf()
}

class AccFlw5Stp3DeclareViewModel: AccFlw5Stp3DeclareViewModelType {
    
    weak var coordinatorDelegate: AccFlw5Stp3DeclareVMCrdinatorDlgt?
    weak var delegate: AccFlw5Stp3DeclareViewModelDelegate?
    
    var selectedFiles: [FileInfo] = []
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func goToAccFlow5Step4() {
        accFiles = []
        for item in selectedFiles {
            if let item = item.data {
                accFiles.append(item)
            }
        }
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
    
    func sendFile(image: UIImage) {
        Loading.shared.show(presented: true)
        guard let data = image.pngData() else { return }
        APIService.sendFile(data: data) { [weak self] model, error in
            Loading.shared.hide()
            guard let self = self else { return }
            
            if let error = error {
                self.delegate?.showError(title: Strings.errorTitle,
                                         message: error.message)
            } else if let model {
                let info = FileInfo(image: image, data: model)
                self.selectedFiles.append(info)
                self.delegate?.reloadData()
            }
        }
    }
}
