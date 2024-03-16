//
//  ReqFlw4Stp4LicenseViewModel.swift
//  Copilot
//
//  Created by Jamal on 3/8/24.
//

import Foundation

protocol ReqFlw6Stp3InspectionVMCrdntrDelegate: AnyObject {
    func getBack()
    func goToSuccess(title: String)
}

protocol ReqFlw6Stp3InspectionViewModelDelegate: BaseViewModelDelegate {
    func removeSelectedFile()
}

protocol ReqFlw6Stp3InspectionViewModelType: AnyObject {
    var coordinatorDelegate: ReqFlw6Stp3InspectionVMCrdntrDelegate? { get set }
    var delegate: ReqFlw6Stp3InspectionViewModelDelegate? { get set }
    var uploadedFileInfo: UploadRequestFile? { get set }
    func getBack()
    func sendFile(data: Data)
    func createCase(licensePlate: String,
                    note: String,
                    nameSurname: String,
                    receiverPersonName: String,
                    receiverPersonTC: String)
}

class ReqFlw6Stp3InspectionViewModel: ReqFlw6Stp3InspectionViewModelType {
    
    weak var coordinatorDelegate: ReqFlw6Stp3InspectionVMCrdntrDelegate?
    weak var delegate: ReqFlw6Stp3InspectionViewModelDelegate?
    var uploadedFileInfo: UploadRequestFile?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func sendFile(data: Data) {
        APIService.sendFile(data: data) { [weak self] model, error in
            Loading.shared.hide()
            guard let self = self else { return }
            
            if let error = error {
                delegate?.removeSelectedFile()
                self.delegate?.showError(title: Strings.errorTitle,
                                         message: error.message)
            } else if let model {
                print(model)
                self.uploadedFileInfo = model
            }
        }
    }
    
    func createCase(licensePlate: String,
                    note: String,
                    nameSurname: String,
                    receiverPersonName: String,
                    receiverPersonTC: String) {
        
        Loading.shared.show()
        APIService.createInspectionCase(licensePlate: licensePlate,
                                        note: note,
                                        nameSurname: nameSurname,
                                        receiverPersonName: receiverPersonName,
                                        receiverPersonTC: receiverPersonTC,
                                        fileInfo: uploadedFileInfo)
        { [weak self] model, error in
            Loading.shared.hide()
            guard let self = self else { return }
            
            if let error = error {
                self.delegate?.showError(title: Strings.errorTitle,
                                         message: error.message)
            } else if model != nil {
                coordinatorDelegate?.goToSuccess(title: Strings.inspectionOperations)
            }
        }
        
    }
}
