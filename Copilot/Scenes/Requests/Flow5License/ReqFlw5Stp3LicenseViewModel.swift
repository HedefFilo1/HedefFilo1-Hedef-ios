//
//  ReqFlw4Stp4LicenseViewModel.swift
//  Copilot
//
//  Created by Jamal on 3/8/24.
//

import Foundation

protocol ReqFlw5Stp3LicenseVMCoordinatorDelegate: AnyObject {
    func getBack()
    func goToSuccess(title: String)
}

protocol ReqFlw5Stp3LicenseViewModelDelegate: BaseViewModelDelegate {
    func removeSelectedFile()
}

protocol ReqFlw5Stp3LicenseViewModelType: AnyObject {
    var coordinatorDelegate: ReqFlw5Stp3LicenseVMCoordinatorDelegate? { get set }
    var delegate: ReqFlw5Stp3LicenseViewModelDelegate? { get set }
    var uploadedFileInfo: UploadRequestFile? { get set }
    func getBack()
    func sendFile(data: Data)
    func createCase(licensePlate: String,
                    note: String,
                    kmValue: Int,
                    description: String,
                    nameSurname: String,
                    deliveryPersonName: String,
                    deliveryPersonPhone: String,
                    deliveryAddress: String)
}

class ReqFlw5Stp3LicenseViewModel: ReqFlw5Stp3LicenseViewModelType {
    
    weak var coordinatorDelegate: ReqFlw5Stp3LicenseVMCoordinatorDelegate?
    weak var delegate: ReqFlw5Stp3LicenseViewModelDelegate?
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
                self.uploadedFileInfo = model
            }
        }
    }
    
    func createCase(licensePlate: String,
                    note: String,
                    kmValue: Int,
                    description: String,
                    nameSurname: String,
                    deliveryPersonName: String,
                    deliveryPersonPhone: String,
                    deliveryAddress: String) {
        
        Loading.shared.show()
        APIService.createLicenseCase(licensePlate: licensePlate,
                                     note: note,
                                     kmValue: kmValue,
                                     description: description,
                                     nameSurname: nameSurname,
                                     deliveryPersonName: deliveryPersonName,
                                     deliveryPersonPhone: deliveryPersonPhone,
                                     deliveryAddress: deliveryAddress,
                                     fileInfo: uploadedFileInfo) { [weak self] model, error in
            Loading.shared.hide()
            guard let self = self else { return }
            
            if let error = error {
                self.delegate?.showError(title: Strings.errorTitle,
                                         message: error.message)
            } else if model != nil {
                coordinatorDelegate?.goToSuccess(title: Strings.lostLicenseOperations)
            }
        }
    }
}
