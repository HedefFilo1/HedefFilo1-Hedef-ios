//
//  ReqFlw4Stp4LicenseViewModel.swift
//  Copilot
//
//  Created by Jamal on 3/8/24.
//

import Foundation

protocol ReqFlw6Stp3InspectionVMCoordinatorDelegate: AnyObject {
    func getBack()
}

protocol ReqFlw6Stp3InspectionViewModelDelegate: BaseViewModelDelegate {
    
}

protocol ReqFlw6Stp3InspectionViewModelType: AnyObject {
    var coordinatorDelegate: ReqFlw6Stp3InspectionVMCoordinatorDelegate? { get set }
    var delegate: ReqFlw6Stp3InspectionViewModelDelegate? { get set }
    func getBack()
    func sendFile(data: Data)
}

class ReqFlw6Stp3InspectionViewModel: ReqFlw6Stp3InspectionViewModelType {
    
    weak var coordinatorDelegate: ReqFlw6Stp3InspectionVMCoordinatorDelegate?
    weak var delegate: ReqFlw6Stp3InspectionViewModelDelegate?
    
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
