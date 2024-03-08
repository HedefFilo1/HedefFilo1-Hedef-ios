//
//  ReqFlw4Stp3PlateViewModel.swift
//  Copilot
//
//  Created by Jamal on 3/5/24.
//

import Foundation

protocol ReqFlw4Stp3PlateVMCoordinatorDelegate: AnyObject {
    func getBack()
}

protocol ReqFlw4Stp3PlateViewModelDelegate: BaseViewModelDelegate {
    
}

protocol ReqFlw4Stp3PlateViewModelType: AnyObject {
    var coordinatorDelegate: ReqFlw4Stp3PlateVMCoordinatorDelegate? { get set }
    var delegate: ReqFlw4Stp3PlateViewModelDelegate? { get set }
    func getBack()
    func sendFile(data: Data)
}

class ReqFlw4Stp3PlateViewModel: ReqFlw4Stp3PlateViewModelType {
    
    weak var coordinatorDelegate: ReqFlw4Stp3PlateVMCoordinatorDelegate?
    weak var delegate: ReqFlw4Stp3PlateViewModelDelegate?
    
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
