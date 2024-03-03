//
//  RequestsViewModel.swift
//  Copilot
//
//  Created by Jamal on 3/4/24.
//

import Foundation

protocol RequestsViewModelCoordinatorDelegate: AnyObject {
    func getBack()
}

protocol RequestsViewModelDelegate: BaseViewModelDelegate {
    
}

protocol RequestsViewModelType: AnyObject {
    var coordinatorDelegate: RequestsViewModelCoordinatorDelegate? { get set }
    var delegate: RequestsViewModelDelegate? { get set }
    func getBack()
}

class RequestsViewModel: RequestsViewModelType {
    
    weak var coordinatorDelegate: RequestsViewModelCoordinatorDelegate?
    weak var delegate: RequestsViewModelDelegate?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
}
