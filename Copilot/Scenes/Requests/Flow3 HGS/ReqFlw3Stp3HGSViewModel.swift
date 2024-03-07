//
//  ReqFlw3Stp3HGSViewModel.swift
//  Copilot
//
//  Created by Jamal on 3/5/24.
//

import Foundation

protocol ReqFlw3Stp3HGSVMCoordinatorDelegate: AnyObject {
    func getBack()
}

protocol ReqFlw3Stp3HGSViewModelDelegate: BaseViewModelDelegate {
    
}

protocol ReqFlw3Stp3HGSViewModelType: AnyObject {
    var coordinatorDelegate: ReqFlw3Stp3HGSVMCoordinatorDelegate? { get set }
    var delegate: ReqFlw3Stp3HGSViewModelDelegate? { get set }
    func getBack()
    func sendFile(data: Data)
}

class ReqFlw3Stp3HGSViewModel: ReqFlw3Stp3HGSViewModelType {
    
    weak var coordinatorDelegate: ReqFlw3Stp3HGSVMCoordinatorDelegate?
    weak var delegate: ReqFlw3Stp3HGSViewModelDelegate?
    
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
