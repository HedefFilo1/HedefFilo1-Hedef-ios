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
    func setProfile()
}

protocol ReqFlw2Stp3VehicleViewModelType: AnyObject {
    var coordinatorDelegate: ReqFlw2Stp3VehicleVMCoordinatorDelegate? { get set }
    var delegate: ReqFlw2Stp3VehicleViewModelDelegate? { get set }
    var uploadedFileInfo: UploadRequestFile? { get set }
    var reasons: [ImpoundCarReason] { get set }
    var cities: [TurkeyCity] { get set }
    var profile: GetProfile? { get set }
    func getProfile()
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
        ImpoundCarReason(field: "USE_OF_ALCOHOL", title: Strings.drinkingAndDriving),
        ImpoundCarReason(field: "MISSING_DOCUMENT", title: Strings.missingDocument),
        ImpoundCarReason(field: "FAULTY_PARKING", title: Strings.incorrectParking),
        ImpoundCarReason(field: "INJURY", title: Strings.injuryFatalAccident),
        ImpoundCarReason(field: "OTHER", title: Strings.other)
    ]
    
    var cities: [TurkeyCity] = turkeyCitiesList
    var profile: GetProfile?
    
    func getProfile() {
        Loading.shared.show()
        APIService.getProfile { [weak self] model, error in
            Loading.shared.hide()
            guard let self = self else {return}
            
            if let profile = model {
                self.profile = profile
                self.delegate?.setProfile()
            } else
            
            if let error = error {
                self.delegate?.showError(title: Strings.errorTitle,
                                         message: error.message)
                return
            }
        }
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
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
}
