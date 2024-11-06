//
//  AccFlw4Stp4NoAgreementReportViewModel.swift
//  Copilot
//
//  Created by Jamal on 2/22/24.
//

import Foundation
import UIKit

protocol AccFlw4Stp4NoAgreementReportVMCrdntrDlgt: AnyObject {
    func getBack()
    func goToFlow4Step5()
}

protocol AccFlw4Stp4NoAgreementReportVMDelegate: BaseViewModelDelegate {
    func reloadData()
}

protocol AccFlw4Stp4NoAgreementReportVModelType: AnyObject {
    var coordinatorDelegate: AccFlw4Stp4NoAgreementReportVMCrdntrDlgt? { get set }
    var delegate: AccFlw4Stp4NoAgreementReportVMDelegate? { get set }
    var selectedFiles: [FileInfo] { get set }
    func sendFile(image: UIImage)
    func getBack()
    func goToFlow4Step5()
}

class AccFlw4Stp4NoAgreementReportViewModel: AccFlw4Stp4NoAgreementReportVModelType {
    var selectedFiles: [FileInfo] = []
    
    weak var coordinatorDelegate: AccFlw4Stp4NoAgreementReportVMCrdntrDlgt?
    weak var delegate: AccFlw4Stp4NoAgreementReportVMDelegate?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func goToFlow4Step5() {
        accFiles = []
        for item in selectedFiles {
            if let item = item.data {
                accFiles.append(item)
            }
        }
        coordinatorDelegate?.goToFlow4Step5()
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
