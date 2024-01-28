//
//  Flow1Step3TireTypesViewModel.swift
//  Copilot
//
//  Created by Jamal on 12/25/23.
//

import Foundation

protocol Flow1Step3TireTypesVMCoordinatorDelegate: AnyObject {
    func getBack()
    func goToFlow1Step4Result()
}

protocol Flow1Step3TireTypesViewModelDelegate: BaseViewModelDelegate {
    
}

protocol Flow1Step3TireTypesViewModelType: AnyObject {
    var coordinatorDelegate: Flow1Step3TireTypesVMCoordinatorDelegate? { get set }
    var delegate: Flow1Step3TireTypesViewModelDelegate? { get set }
    
    func getBack()
    func goToFlow1Step4Result()
    func requestTire(tireType: TireSupportType)
}

class Flow1Step3TireTypesViewModel: Flow1Step3TireTypesViewModelType {
    
    weak var coordinatorDelegate: Flow1Step3TireTypesVMCoordinatorDelegate?
    weak var delegate: Flow1Step3TireTypesViewModelDelegate?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func goToFlow1Step4Result() {
        coordinatorDelegate?.goToFlow1Step4Result()
    }
    
    func requestTire(tireType: TireSupportType) {
        Loading.shared.show()
        APIService.createCase(tireType: tireType,
                              towTruck: false,
                              supplierName: "",
                              supplierPhone: "",
                              city: "",
                              district: "",
                              appointmentDate: Date()) { [weak self] _, error in
            Loading.shared.hide()
            guard let self = self else { return }
            
            if let error = error {
                self.delegate?.showError(title: Strings.errorTitle,
                                         message: error.message)
            } else {
                self.goToFlow1Step4Result()
            }
        }
    }
}