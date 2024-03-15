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
    func goToSuccess(title: String)
}

protocol ReqFlw3Stp3HGSViewModelDelegate: BaseViewModelDelegate {
    func removeSelectedFile()
}

protocol ReqFlw3Stp3HGSViewModelType: AnyObject {
    var coordinatorDelegate: ReqFlw3Stp3HGSVMCoordinatorDelegate? { get set }
    var delegate: ReqFlw3Stp3HGSViewModelDelegate? { get set }
    var ogsHgsTypes: [OgsHgsType] { get set }
    var uploadedFileInfo: UploadRequestFile? { get set }
    func getBack()
    func sendFile(data: Data)
    func createCase(licensePlate: String,
                    note: String,
                    nameSurname: String,
                    receiverPersonName: String,
                    receiverPersonPhone: String,
                    ogsHgsType: String,
                    deliveryAddress: String)
}

class ReqFlw3Stp3HGSViewModel: ReqFlw3Stp3HGSViewModelType {
    
    weak var coordinatorDelegate: ReqFlw3Stp3HGSVMCoordinatorDelegate?
    weak var delegate: ReqFlw3Stp3HGSViewModelDelegate?
    var uploadedFileInfo: UploadRequestFile?
    
    var ogsHgsTypes: [OgsHgsType] = [
        OgsHgsType(field: "FAILURE", title: "FAILURE"),
        OgsHgsType(field: "DAMAGE", title: "DAMAGE"),
        OgsHgsType(field: "TIRE", title: "TIRE"),
        OgsHgsType(field: "MAINTENANCE", title: "MAINTENANCE"),
        OgsHgsType(field: "INVOICE_OBJECTION", title: "INVOICE_OBJECTION"),
        OgsHgsType(field: "LOGO", title: "LOGO"),
        OgsHgsType(field: "PENALTY_INVOICE", title: "PENALTY_INVOICE"),
        OgsHgsType(field: "TRAFFIC_POLICY", title: "TRAFFIC_POLICY"),
        OgsHgsType(field: "VEHICLE_RETURN", title: "VEHICLE_RETURN"),
        OgsHgsType(field: "OGS_HGS", title: "OGS_HGS"),
        OgsHgsType(field: "OCCUPIED_VEHICLE", title: "OCCUPIED_VEHICLE"),
        OgsHgsType(field: "MISSING_LICENSE", title: "MISSING_LICENSE"),
        OgsHgsType(field: "MISSING_PLATE", title: "MISSING_PLATE"),
        OgsHgsType(field: "VEHICLE_INSPECTION", title: "VEHICLE_INSPECTION"),
        OgsHgsType(field: "FOREIGN_EXIT", title: "FOREIGN_EXIT"),
        OgsHgsType(field: "OTHER", title: "OTHER")
    ]
    
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
                    ogsHgsType: String,
                    deliveryAddress: String) {
        
        Loading.shared.show()
        APIService.createHGSCase(licensePlate: licensePlate,
                                 note: note,
                                 nameSurname: nameSurname,
                                 receiverPersonName: receiverPersonName,
                                 receiverPersonPhone: receiverPersonPhone,
                                 ogsHgsType: ogsHgsType,
                                 deliveryAddress: deliveryAddress,
                                 fileInfo: uploadedFileInfo) { [weak self] model, error in
            Loading.shared.hide()
            guard let self = self else { return }
            
            if let error = error {
                self.delegate?.showError(title: Strings.errorTitle,
                                         message: error.message)
            } else if model != nil {
                coordinatorDelegate?.goToSuccess(title: Strings.hgsOperations)
            }
        }
    }
}
