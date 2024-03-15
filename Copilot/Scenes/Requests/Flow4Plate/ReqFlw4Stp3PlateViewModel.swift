//
//  ReqFlw4Stp3PlateViewModel.swift
//  Copilot
//
//  Created by Jamal on 3/5/24.
//

import Foundation

protocol ReqFlw4Stp3PlateVMCoordinatorDelegate: AnyObject {
    func getBack()
    func goToSuccess(title: String)
}

protocol ReqFlw4Stp3PlateViewModelDelegate: BaseViewModelDelegate {
    func removeSelectedFile()
}

protocol ReqFlw4Stp3PlateViewModelType: AnyObject {
    var coordinatorDelegate: ReqFlw4Stp3PlateVMCoordinatorDelegate? { get set }
    var delegate: ReqFlw4Stp3PlateViewModelDelegate? { get set }
    var uploadedFileInfo: UploadRequestFile? { get set }
    var causeOfLosts: [String] { get set }
    var numberOfLostPlates: [Int] { get set }
    func getBack()
    func sendFile(data: Data)
    func createCase(licensePlate: String,
                    note: String,
                    kmValue: Int,
                    description: String,
                    nameSurname: String,
                    numberPlate: Int,
                    deliveryPersonName: String,
                    deliveryPersonPhone: String,
                    deliveryAddress: String)
}

class ReqFlw4Stp3PlateViewModel: ReqFlw4Stp3PlateViewModelType {
    
    weak var coordinatorDelegate: ReqFlw4Stp3PlateVMCoordinatorDelegate?
    weak var delegate: ReqFlw4Stp3PlateViewModelDelegate?
    var uploadedFileInfo: UploadRequestFile?
    var causeOfLosts = ["Kayıp", "Değişim"]
    var numberOfLostPlates = [1, 2]
    
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
                    numberPlate: Int,
                    deliveryPersonName: String,
                    deliveryPersonPhone: String,
                    deliveryAddress: String) {
        
        Loading.shared.show()
        APIService.createPlateCase(licensePlate: licensePlate,
                                   note: note,
                                   kmValue: kmValue,
                                   description: description,
                                   nameSurname: nameSurname,
                                   numberPlate: numberPlate,
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
                coordinatorDelegate?.goToSuccess(title: Strings.lostLicensePlateTransactions)
            }
        }
    }
}
