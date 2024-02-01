//
//  Flow5Step2TireChangeViewModel.swift
//  Copilot
//
//  Created by Jamal on 1/23/24.
//

import Foundation

protocol Flow5Step2TireChangeVMCoordinatorDlgt: AnyObject {
    func getBack()
    func goToServices(tireSupportType: TireSupportType, towTruck: Bool)
    func goToServiceDetail(service: Supplier?, appointment: Case?, tireSupportType: TireSupportType?, towTruck: Bool)
}

protocol Flow5Step2TireChangeViewModelDelegate: AnyObject {
    
}

protocol Flow5Step2TireChangeViewModelType: AnyObject {
    var coordinatorDelegate: Flow5Step2TireChangeVMCoordinatorDlgt? { get set }
    var delegate: Flow5Step2TireChangeViewModelDelegate? { get set }
    var tireService: Supplier? { get set }
    func getBack()
    func goToServices()
    func goToServiceDetail()
}

class Flow5Step2TireChangeViewModel: Flow5Step2TireChangeViewModelType {
    
    weak var coordinatorDelegate: Flow5Step2TireChangeVMCoordinatorDlgt?
    weak var delegate: Flow5Step2TireChangeViewModelDelegate?
    
    var tireService: Supplier?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func goToServices() {
        coordinatorDelegate?.goToServices(tireSupportType: .change, towTruck: false)
    }
    
    func goToServiceDetail() {
        coordinatorDelegate?.goToServiceDetail(service: tireService, appointment: nil, tireSupportType: .change, towTruck: false)
    }
}
