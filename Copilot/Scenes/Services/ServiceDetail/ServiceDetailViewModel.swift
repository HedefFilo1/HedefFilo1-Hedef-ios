//
//  ServiceDetailViewModel.swift
//  Copilot
//
//  Created by Jamal on 1/2/24.
//

import Foundation
protocol ServiceDetailVMCoordinatorDelegate: AnyObject {
    func getBack()
}

protocol ServiceDetailViewModelDelegate: BaseViewModelDelegate {
    
}

protocol ServiceDetailViewModelType: AnyObject {
    var coordinatorDelegate: ServiceDetailVMCoordinatorDelegate? { get set }
    var delegate: ServiceDetailViewModelDelegate? { get set }
    var service: Supplier? { get set }
    func getBack()
}

class ServiceDetailViewModel: ServiceDetailViewModelType {
    weak var coordinatorDelegate: ServiceDetailVMCoordinatorDelegate?
    weak var delegate: ServiceDetailViewModelDelegate?
    
    var service: Supplier?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
}
