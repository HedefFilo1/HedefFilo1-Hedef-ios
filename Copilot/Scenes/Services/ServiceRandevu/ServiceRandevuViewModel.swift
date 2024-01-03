//
//  ServiceRandevuViewModel.swift
//  Copilot
//
//  Created by Jamal on 1/3/24.
//

import Foundation

struct MockRandevu {
    let supplier: Supplier
    let date: String
    let time: String
}

protocol ServiceRandevuVMCoordinatorDelegate: AnyObject {
    func getBack()
    func goToConfirmedRandevu(randevu: MockRandevu)
}

protocol ServiceRandevuViewModelDelegate: BaseViewModelDelegate {
    
}

protocol ServiceRandevuViewModelType: AnyObject {
    var coordinatorDelegate: ServiceRandevuVMCoordinatorDelegate? { get set }
    var delegate: ServiceRandevuViewModelDelegate? { get set }
    var randevu: MockRandevu? { get set }
    func getBack()
    func goToConfirmedRandevu()
}

class ServiceRandevuViewModel: ServiceRandevuViewModelType {
    weak var coordinatorDelegate: ServiceRandevuVMCoordinatorDelegate?
    weak var delegate: ServiceRandevuViewModelDelegate?
    
    var randevu: MockRandevu?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func goToConfirmedRandevu() {
        if let randevu = randevu {
            coordinatorDelegate?.goToConfirmedRandevu(randevu: randevu)
        }
    }
}
