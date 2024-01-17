//
//  ServiceTabViewModel.swift
//  Copilot
//
//  Created by Jamal on 12/21/23.
//

import Foundation

protocol ServiceTabViewModelCoordinatorDelegate: AnyObject {
    func goToLastikOperations(service: Supplier?)
}

protocol ServiceTabViewModelDelegate: AnyObject {
    
}

protocol ServiceTabViewModelType: AnyObject {
    var coordinatorDelegate: ServiceTabViewModelCoordinatorDelegate? { get set }
    var delegate: ServiceTabViewModelDelegate? { get set }
    
    func goToLastikOperations(service: Supplier?)
}

class ServiceTabViewModel: ServiceTabViewModelType {
    
    weak var coordinatorDelegate: ServiceTabViewModelCoordinatorDelegate?
    weak var delegate: ServiceTabViewModelDelegate?
    
    func goToLastikOperations(service: Supplier?) {
        coordinatorDelegate?.goToLastikOperations(service: service)
    }
}
