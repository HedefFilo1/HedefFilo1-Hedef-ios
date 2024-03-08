//
//  ReqFlw4Stp4LicenseViewModel.swift
//  Copilot
//
//  Created by Jamal on 3/8/24.
//

import Foundation

protocol ReqFlw5Stp3LicenseVMCoordinatorDelegate: AnyObject {
    func getBack()
}

protocol ReqFlw5Stp3LicenseViewModelDelegate: BaseViewModelDelegate {
    
}

protocol ReqFlw5Stp3LicenseViewModelType: AnyObject {
    var coordinatorDelegate: ReqFlw5Stp3LicenseVMCoordinatorDelegate? { get set }
    var delegate: ReqFlw5Stp3LicenseViewModelDelegate? { get set }
    func getBack()
    func sendFile(data: Data)
}

class ReqFlw5Stp3LicenseViewModel: ReqFlw5Stp3LicenseViewModelType {
    
    weak var coordinatorDelegate: ReqFlw5Stp3LicenseVMCoordinatorDelegate?
    weak var delegate: ReqFlw5Stp3LicenseViewModelDelegate?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func sendFile(data: Data) {
        
        Loading.shared.show()
        APIService.sendFile(data: data) { [weak self] model, error in
            Loading.shared.hide()
            guard let self = self else { return }
            
            if let error = error {
                self.delegate?.showError(title: Strings.errorTitle,
                                         message: error.message)
            } else if let model {
                print(model)
            }
        }
    }
}
