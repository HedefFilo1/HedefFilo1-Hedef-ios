//
//  ServiceFilterViewModel.swift
//  Copilot
//
//  Created by Jamal on 12/29/23.
//

import Foundation

protocol ServiceFilterVMCoordinatorDelegate: AnyObject {
    
}

protocol ServiceFilterViewModelDelegate: AnyObject {
    
}

protocol ServiceFilterViewModelType: AnyObject {
    var coordinatorDelegate: ServiceFilterVMCoordinatorDelegate? { get set }
    var delegate: ServiceFilterViewModelDelegate? { get set }
    var provinces: [String]? { get set }
}

class ServiceFilterViewModel: ServiceFilterViewModelType {
    
    weak var coordinatorDelegate: ServiceFilterVMCoordinatorDelegate?
    weak var delegate: ServiceFilterViewModelDelegate?
    
    var provinces: [String]? = [
        "Istanbul", "Izmir"
    ]
}
