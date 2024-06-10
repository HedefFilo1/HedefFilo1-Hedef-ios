//
//  ReqFlw3Stp3HGSViewModel.swift
//  Copilot
//
//  Created by Jamal on 3/5/24.
//

import Foundation

struct OgsHgsType {
    let field: String
    let title: String
}

protocol ReqFlw3Stp3HGSVMCoordinatorDelegate: AnyObject {
    func getBack()
    func goToSuccess(title: String, message: String)
}

protocol ReqFlw3Stp3HGSViewModelDelegate: BaseViewModelDelegate {
    func setProfile()
    func removeSelectedFile()
}

protocol ReqFlw3Stp3HGSViewModelType: AnyObject {
    var coordinatorDelegate: ReqFlw3Stp3HGSVMCoordinatorDelegate? { get set }
    var delegate: ReqFlw3Stp3HGSViewModelDelegate? { get set }
    var ogsHgsTypes: [OgsHgsType] { get set }
    var uploadedFileInfo: UploadRequestFile? { get set }
    var profile: GetProfile? { get set }
    func getProfile()
    func getBack()
    func sendFile(data: Data)
    func createCase(licensePlate: String,
                    note: String,
                    nameSurname: String,
                    receiverPersonName: String,
                    receiverPersonPhone: String,
                    receiverPersonEmail: String,
                    ogsHgsType: String,
                    deliveryAddress: String)
}

class ReqFlw3Stp3HGSViewModel: ReqFlw3Stp3HGSViewModelType {
    
    weak var coordinatorDelegate: ReqFlw3Stp3HGSVMCoordinatorDelegate?
    weak var delegate: ReqFlw3Stp3HGSViewModelDelegate?
    var uploadedFileInfo: UploadRequestFile?
    
    var ogsHgsTypes: [OgsHgsType] = [
        OgsHgsType(field: "FAILURE", title: Strings.deviceLabelFailure),
        OgsHgsType(field: "USAGE_DETAILS", title: Strings.usageDetails),
        OgsHgsType(field: "NEW_DEMAND", title: Strings.newDemand)
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
                    receiverPersonName: String,
                    receiverPersonPhone: String,
                    receiverPersonEmail: String,
                    ogsHgsType: String,
                    deliveryAddress: String) {
        let phone = receiverPersonPhone.components(separatedBy: .whitespaces).joined()
        Loading.shared.show()
        APIService.createHGSCase(licensePlate: licensePlate,
                                 note: note,
                                 nameSurname: nameSurname,
                                 receiverPersonName: receiverPersonName,
                                 receiverPersonPhone: phone,
                                 receiverPersonEmail: receiverPersonEmail,
                                 ogsHgsType: ogsHgsType,
                                 deliveryAddress: deliveryAddress,
                                 fileInfo: uploadedFileInfo) { [weak self] model, error in
            Loading.shared.hide()
            guard let self = self else { return }
            
            if let error = error {
                self.delegate?.showError(title: Strings.errorTitle,
                                         message: error.message)
            } else if model != nil {
                APIService.addUserAction(pageName: "Demands", actionName: "DEMAND_PROCESS_REQUESTS_HGS_PROCESS")
                let title = App.getString(key: "copilotapp.demandprocessual.processual.demand.hgs.operation.button") ?? ""
                let message = App.getString(key: "copilotapp.demandprocessual.processual.demand.hgs.operation.success.title") ?? ""
                coordinatorDelegate?.goToSuccess(title: title, message: message)
            }
        }
    }
}
