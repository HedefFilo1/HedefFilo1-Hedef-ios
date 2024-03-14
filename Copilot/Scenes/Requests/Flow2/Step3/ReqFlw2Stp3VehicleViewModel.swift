//
//  ReqFlw2Stp3VehicleViewModel.swift
//  Copilot
//
//  Created by Jamal on 3/5/24.
//

import Foundation

struct ImpoundCarReason {
    let field: String
    let title: String
}

protocol ReqFlw2Stp3VehicleVMCoordinatorDelegate: AnyObject {
    func getBack()
    func goToSuccess(title: String)
}

protocol ReqFlw2Stp3VehicleViewModelDelegate: BaseViewModelDelegate {
    func removeSelectedFile()
}

protocol ReqFlw2Stp3VehicleViewModelType: AnyObject {
    var coordinatorDelegate: ReqFlw2Stp3VehicleVMCoordinatorDelegate? { get set }
    var delegate: ReqFlw2Stp3VehicleViewModelDelegate? { get set }
    var uploadedFileInfo: UploadRequestFile? { get set }
    var reasons: [ImpoundCarReason] { get set }
    var cities: [TurkeyCity] { get set }
    func getBack()
    func sendFile(data: Data)
    func createCase(licensePlate: String,
                    note: String,
                    nameSurname: String,
                    impoundCarReason: String,
                    description: String,
                    trafficBranchName: String,
                    trafficBranchPhone: String,
                    carParkName: String,
                    carParkPhone: String,
                    deliveryPersonName: String,
                    deliveryPersonPhone: String,
                    city: String,
                    deliveryAddress: String)
}

class ReqFlw2Stp3VehicleViewModel: ReqFlw2Stp3VehicleViewModelType {
    
    weak var coordinatorDelegate: ReqFlw2Stp3VehicleVMCoordinatorDelegate?
    weak var delegate: ReqFlw2Stp3VehicleViewModelDelegate?
    var uploadedFileInfo: UploadRequestFile?
    
    var reasons: [ImpoundCarReason] = [
        ImpoundCarReason(field: "USE_OF_ALCOHOL", title: "USE_OF_ALCOHOL"),
        ImpoundCarReason(field: "MISSING_DOCUMENT", title: "MISSING_DOCUMENT"),
        ImpoundCarReason(field: "FAULTY_PARKING", title: "FAULTY_PARKING"),
        ImpoundCarReason(field: "INJURY", title: "INJURY"),
        ImpoundCarReason(field: "OTHER", title: "OTHER")
    ]
    
    var cities: [TurkeyCity] = turkeyCitiesList
    
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
                    nameSurname: String,
                    impoundCarReason: String,
                    description: String,
                    trafficBranchName: String,
                    trafficBranchPhone: String,
                    carParkName: String,
                    carParkPhone: String,
                    deliveryPersonName: String,
                    deliveryPersonPhone: String,
                    city: String,
                    deliveryAddress: String) {
        Loading.shared.show()
        APIService.createVehicleCase(licensePlate: licensePlate,
                                     note: note,
                                     nameSurname: nameSurname,
                                     impoundCarReason: impoundCarReason,
                                     description: description,
                                     trafficBranchName: trafficBranchName,
                                     trafficBranchPhone: trafficBranchPhone,
                                     carParkName: carParkName,
                                     carParkPhone: carParkPhone,
                                     deliveryPersonName: deliveryPersonName,
                                     deliveryPersonPhone: deliveryPersonPhone,
                                     city: city,
                                     deliveryAddress: deliveryAddress,
                                     fileInfo: uploadedFileInfo) { [weak self] model, error in
            Loading.shared.hide()
            guard let self = self else { return }
            
            if let error = error {
                self.delegate?.showError(title: Strings.errorTitle,
                                         message: error.message)
            } else if model != nil {
                coordinatorDelegate?.goToSuccess(title: Strings.completedVehicleOperations)
            }
        }
    }
}
