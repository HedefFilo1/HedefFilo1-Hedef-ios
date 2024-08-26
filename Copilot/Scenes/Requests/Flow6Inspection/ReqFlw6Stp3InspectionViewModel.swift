//
//  ReqFlw4Stp4LicenseViewModel.swift
//  Copilot
//
//  Created by Jamal on 3/8/24.
//

import Foundation

protocol ReqFlw6Stp3InspectionVMCrdntrDelegate: AnyObject {
    func getBack()
    func goToSuccess(title: String, message: String, description: String)
}

protocol ReqFlw6Stp3InspectionViewModelDelegate: BaseViewModelDelegate {
    func removeSelectedFile()
    func setProfile()
}

protocol ReqFlw6Stp3InspectionViewModelType: AnyObject {
    var coordinatorDelegate: ReqFlw6Stp3InspectionVMCrdntrDelegate? { get set }
    var delegate: ReqFlw6Stp3InspectionViewModelDelegate? { get set }
    var uploadedFileInfo: UploadRequestFile? { get set }
    var profile: GetProfile? { get set }
    func getProfile()
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
        APIService.createInspectionCase(
            licensePlate: licensePlate,
            note: note,
            nameSurname: nameSurname,
            receiverPersonName: receiverPersonName,
            receiverPersonTC: receiverPersonTC,
            fileInfo: uploadedFileInfo
        ) { [weak self] model, error in
            
            Loading.shared.hide()
            guard let self = self else { return }
            
            if let error = error {
                self.delegate?.showError(title: Strings.errorTitle,
                                         message: error.message)
            } else if model != nil {
                APIService.addUserAction(pageName: "Demands", actionName: "DEMAND_PROCESS_REQUESTS_EXAMINATION_PROCESS")
                let title = App.getString(key: "copilotapp.demandprocessual.processual.demand.inspection.operation.button") ?? ""
                let message = App.getString(key: "copilotapp.demandprocessual.processual.demand.inspection.operation.success.title") ?? ""
                let description = App.getString(key: "copilotapp.demanoperationalservice.request.fleet.manager.description.examination") ?? ""
                coordinatorDelegate?.goToSuccess(title: title, message: message, description: description)
            }
        }
        
    }
}
