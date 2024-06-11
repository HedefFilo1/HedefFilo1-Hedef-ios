//
//  RequestDetailViewModel.swift
//  Copilot
//
//  Created by Jamal on 3/18/24.
//

import Foundation
protocol RequestDetailVMCrdntrDelegate: AnyObject {
    func getBack()
    func goToCanceledRequest(title: String)
}

protocol RequestDetailViewModelDelegate: BaseViewModelDelegate {
    
}

protocol RequestDetailViewModelType: AnyObject {
    var coordinatorDelegate: RequestDetailVMCrdntrDelegate? { get set }
    var delegate: RequestDetailViewModelDelegate? { get set }
    var item: Task? { get set }
    func getBack()
    func goToCanceledRequest()
    func cancelTask()
}

class RequestDetailViewModel: RequestDetailViewModelType {
    
    weak var coordinatorDelegate: RequestDetailVMCrdntrDelegate?
    weak var delegate: RequestDetailViewModelDelegate?
    var item: Task?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func goToCanceledRequest() {
        let title = item?.subjectResult ?? ""
        coordinatorDelegate?.goToCanceledRequest(title: title)
    }
    
    func cancelTask() {
        guard let id = item?.id else { return }
        Loading.shared.show()
        APIService.cancelTask(id: id) { [weak self] _, error in
            Loading.shared.hide()
            guard let self = self else {return}
            
            if let error = error {
                self.delegate?.showError(title: Strings.errorTitle,
                                         message: error.message)
                return
            }
            self.goToCanceledRequest()
        }
    }
}
