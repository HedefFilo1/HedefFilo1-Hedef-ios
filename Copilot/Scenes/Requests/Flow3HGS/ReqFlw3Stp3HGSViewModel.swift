//
//  ReqFlw3Stp3HGSViewModel.swift
//  Copilot
//
//  Created by Jamal on 3/5/24.
//

import Foundation

protocol ReqFlw3Stp3HGSVMCoordinatorDelegate: AnyObject {
    func getBack()
    func goToSuccess()
}

protocol ReqFlw3Stp3HGSViewModelDelegate: BaseViewModelDelegate {
    
}

protocol ReqFlw3Stp3HGSViewModelType: AnyObject {
    var coordinatorDelegate: ReqFlw3Stp3HGSVMCoordinatorDelegate? { get set }
    var delegate: ReqFlw3Stp3HGSViewModelDelegate? { get set }
    func getBack()
    func sendFile(data: Data)
    func createCase(licensePlate: String,
                    note: String,
                    nameSurname: String,
                    receiverPersonName: String,
                    receiverPersonPhone: String,
                    deliveryAddress: String)
}

class ReqFlw3Stp3HGSViewModel: ReqFlw3Stp3HGSViewModelType {
    
    weak var coordinatorDelegate: ReqFlw3Stp3HGSVMCoordinatorDelegate?
    weak var delegate: ReqFlw3Stp3HGSViewModelDelegate?
    var uploadedFileInfo: UploadRequestFile?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func sendFile(data: Data) {
        
        APIService.sendFile(data: data) { [weak self] model, error in
            Loading.shared.hide()
            guard let self = self else { return }
            
            if let error = error {
                self.delegate?.showError(title: Strings.errorTitle,
                                         message: error.message)
            } else if let model {
                self.uploadedFileInfo = model
            }
        }
    }
    
    func createCase(licensePlate: String,
                    note: String,
                    nameSurname: String,
                    receiverPersonName: String,
                    receiverPersonPhone: String,
                    deliveryAddress: String) {
        
        APIService.createHGSCase(licensePlate: licensePlate,
                                 note: note,
                                 nameSurname: nameSurname,
                                 receiverPersonName: receiverPersonName,
                                 receiverPersonPhone: receiverPersonPhone,
                                 deliveryAddress: deliveryAddress,
                                 fileInfo: uploadedFileInfo) { [weak self] model, error in
            Loading.shared.hide()
            guard let self = self else { return }
            
            if let error = error {
                self.delegate?.showError(title: Strings.errorTitle,
                                         message: error.message)
            } else if let model {
                coordinatorDelegate?.goToSuccess()
            }
        }
    }
}
