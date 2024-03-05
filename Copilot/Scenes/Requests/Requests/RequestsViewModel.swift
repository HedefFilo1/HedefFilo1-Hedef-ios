//
//  RequestsViewModel.swift
//  Copilot
//
//  Created by Jamal on 3/4/24.
//

import Foundation

protocol RequestsViewModelCoordinatorDelegate: AnyObject {
    func getBack()
    func goToReqFlw1Stp2()
    func goToReqFlw2Stp2Questions()
}

protocol RequestsViewModelDelegate: BaseViewModelDelegate {
    
}

protocol RequestsViewModelType: AnyObject {
    var coordinatorDelegate: RequestsViewModelCoordinatorDelegate? { get set }
    var delegate: RequestsViewModelDelegate? { get set }
    func getBack()
    func goToReqFlw1Stp2()
    func goToReqFlw2Stp2Questions()
}

class RequestsViewModel: RequestsViewModelType {
    
    weak var coordinatorDelegate: RequestsViewModelCoordinatorDelegate?
    weak var delegate: RequestsViewModelDelegate?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func goToReqFlw1Stp2() {
        coordinatorDelegate?.goToReqFlw1Stp2()
    }
    
    func goToReqFlw2Stp2Questions() {
        coordinatorDelegate?.goToReqFlw2Stp2Questions()
    }
}
