//
//  RequestListViewModel.swift
//  Copilot
//
//  Created by Jamal on 3/17/24.
//

import Foundation

protocol RequestListVMCrdntrDelegate: AnyObject {
    func getBack()
    func goToRequestDetail(item: Task)
}

protocol RequestListViewModelDelegate: BaseViewModelDelegate {
    func reloadData()
}

protocol RequestListViewModelType: AnyObject {
    var coordinatorDelegate: RequestListVMCrdntrDelegate? { get set }
    var delegate: RequestListViewModelDelegate? { get set }
    var tasks: [Task]? { get set }
    func getBack()
    func goToRequestDetail(item: Task)
    func getTasks()
    func getRequests()
}

class RequestListViewModel: RequestListViewModelType {
    
    weak var coordinatorDelegate: RequestListVMCrdntrDelegate?
    weak var delegate: RequestListViewModelDelegate?
    var tasks: [Task]?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func goToRequestDetail(item: Task) {
        coordinatorDelegate?.goToRequestDetail(item: item)
    }
    
    func getTasks() {
        Loading.shared.show()
        APIService.getTasks { [weak self] model, error in
            Loading.shared.hide()
            guard let self = self else {return}
            
            if let model = model {
                self.tasks = model
                self.delegate?.reloadData()
            } else
            
            if let error = error {
                self.delegate?.showError(title: Strings.errorTitle,
                                         message: error.message)
                return
            }
        }
    }
    
    func getRequests() {
        Loading.shared.show()
        APIService.getRequests { [weak self] model, error in
            Loading.shared.hide()
            guard let self = self else {return}
            
            if let model = model {
//                self.tasks = model
            } else
            
            if let error = error {
                self.delegate?.showError(title: Strings.errorTitle,
                                         message: error.message)
                return
            }
        }
    }
}
