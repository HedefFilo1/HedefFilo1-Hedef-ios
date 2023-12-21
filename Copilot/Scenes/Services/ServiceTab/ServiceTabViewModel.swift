//
//  ServiceTabViewModel.swift
//  Copilot
//
//  Created by Jamal on 12/21/23.
//

import Foundation

protocol ServiceTabViewModelCoordinatorDelegate: AnyObject {
    func goToLastikOperations()
}

protocol ServiceTabViewModelDelegate: AnyObject {
    
}

protocol ServiceTabViewModelType: AnyObject {
    var coordinatorDelegate: ServiceTabViewModelCoordinatorDelegate? { get set }
    var delegate: ServiceTabViewModelDelegate? { get set }
    
    func goToLastikOperations()
}

class ServiceTabViewModel: ServiceTabViewModelType {
    
    var coordinatorDelegate: ServiceTabViewModelCoordinatorDelegate?
    weak var delegate: ServiceTabViewModelDelegate?
    
    func goToLastikOperations() {
        coordinatorDelegate?.goToLastikOperations()
    }
}
