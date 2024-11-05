//
//  AccFlw1Stp4ReportViewModel.swift
//  Copilot
//
//  Created by Jamal on 2/16/24.
//

import Foundation
import PDFKit
import UIKit

var accFiles: [UploadRequestFile] = []

struct FileInfo {
    let image: UIImage?
    let data: UploadRequestFile?
}

protocol AccFlw1Stp4ReportVMCrdinatorDlgt: AnyObject {
    func getBack()
    func goToAccFlw1Stp5Leaks()
    func goToGuide()
    func showReportPdf(doc: PDFDocument, title: String)
}

protocol AccFlw1Stp4ReportViewModelDelegate: BaseViewModelDelegate {
    func removeSelectedFile()
    func reloadData()
}

protocol AccFlw1Stp4ReportViewModelType: AnyObject {
    var coordinatorDelegate: AccFlw1Stp4ReportVMCrdinatorDlgt? { get set }
    var delegate: AccFlw1Stp4ReportViewModelDelegate? { get set }
    
    var selectedFiles: [FileInfo?] { get set }
    var selectedCarImages: [FileInfo?] { get set }
    
    func getBack()
    func goToAccFlw1Stp5Leaks()
    func goToGuide()
    func showReportPdf()
    func sendFile(image: UIImage, index: Int)
    func sendCarFile(image: UIImage)
}

class AccFlw1Stp4ReportViewModel: AccFlw1Stp4ReportViewModelType {
    
    weak var coordinatorDelegate: AccFlw1Stp4ReportVMCrdinatorDlgt?
    weak var delegate: AccFlw1Stp4ReportViewModelDelegate?
    var uploadedFileInfo: UploadRequestFile?
    
    var selectedFiles: [FileInfo?] = [
        nil, nil, nil, nil, nil
    ]
    
    var selectedCarImages: [FileInfo?] = []
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func goToAccFlw1Stp5Leaks() {
        accFiles = []
        for item in selectedFiles {
            if let item = item?.data {
                accFiles.append(item)
            }
        }
        
        for item in selectedCarImages {
            if let item = item?.data {
                accFiles.append(item)
            }
        }
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
    
    func sendFile(image: UIImage, index: Int) {
        Loading.shared.show(presented: true)
        guard let data = image.pngData() else { return }
        APIService.sendFile(data: data) { [weak self] model, error in
            Loading.shared.hide()
            guard let self = self else { return }
            
            if let error = error {
                delegate?.removeSelectedFile()
                self.delegate?.showError(title: Strings.errorTitle,
                                         message: error.message)
            } else if let model {
                //                self.uploadedFileInfo = model
                let info = FileInfo(image: image, data: model)
                self.selectedFiles[index] = info
                self.delegate?.reloadData()
            }
        }
    }
    
    func sendCarFile(image: UIImage) {
        Loading.shared.show(presented: true)
        guard let data = image.pngData() else { return }
        APIService.sendFile(data: data) { [weak self] model, error in
            Loading.shared.hide()
            guard let self = self else { return }
            
            if let error = error {
                delegate?.removeSelectedFile()
                self.delegate?.showError(title: Strings.errorTitle,
                                         message: error.message)
            } else if let model {
                //                self.uploadedFileInfo = model
                let info = FileInfo(image: image, data: model)
                self.selectedCarImages.append(info)
                self.delegate?.reloadData()
            }
        }
    }
    
}
