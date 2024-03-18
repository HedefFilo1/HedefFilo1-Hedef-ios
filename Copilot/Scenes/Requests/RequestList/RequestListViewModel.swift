//
//  RequestListViewModel.swift
//  Copilot
//
//  Created by Jamal on 3/17/24.
//

import Foundation

protocol RequestListVMCrdntrDelegate: AnyObject {
    func getBack()
    func goToRequestDetail(title: String)
}

protocol RequestListViewModelDelegate: BaseViewModelDelegate {

}

protocol RequestListViewModelType: AnyObject {
    var coordinatorDelegate: RequestListVMCrdntrDelegate? { get set }
    var delegate: RequestListViewModelDelegate? { get set }

    func getBack()
    func goToRequestDetail(title: String)
}

class RequestListViewModel: RequestListViewModelType {
    
    weak var coordinatorDelegate: RequestListVMCrdntrDelegate?
    weak var delegate: RequestListViewModelDelegate?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func goToRequestDetail(title: String) {
        coordinatorDelegate?.goToRequestDetail(title: title)
    }
}
