//
//  LastikOperationsViewModel.swift
//  Copilot
//
//  Created by Jamal on 12/21/23.
//

import Foundation

protocol TireOperationsVMCoordinatorDelegate: AnyObject {
    func getBack()
    func goToFlow1Step2NewTire()
    func goToFlow2Step2TireTypes()
    func goToFlow3Step2Damage()
    
//    func goToRequestNewLastik()
//    func goToLastikRandevuConfirmation()
//    func goToLastikChange()
//    func goToServiceDetail(service: Supplier?, appointment: Case?, tireSupportType: TireSupportType?)
//    func goToLastikFromManger()
}

protocol TireOperationsViewModelDelegate: BaseViewModelDelegate {
    func setTire()
}

protocol TireOperationsViewModelType: AnyObject {
    var coordinatorDelegate: TireOperationsVMCoordinatorDelegate? { get set }
    var delegate: TireOperationsViewModelDelegate? { get set }
    var appointment: Case? { get set }
    var tire: Tire? { get set }
    
    func getBack()
    func goToRequestNewLastik()
    func goToFlow3Step2Damage()
    func goToLastikChange()
    func goToServiceDetail()
    func getTire()
}

class TireOperationsViewModel: TireOperationsViewModelType {
    
    weak var coordinatorDelegate: TireOperationsVMCoordinatorDelegate?
    weak var delegate: TireOperationsViewModelDelegate?
    
    var appointment: Case?
    var tire: Tire?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func goToRequestNewLastik() {
//        if true {
////            coordinatorDelegate?.goToFlow1Step2NewTire()
//            coordinatorDelegate?.goToFlow2Step2TireTypes()
//            return
//        }
        
        Loading.shared.show()
        APIService.getTireControl { [weak self] model, error in
            Loading.shared.hide()
            guard let self = self else { return }
            
            if let model {
                for item in model where item.available {
                    self.coordinatorDelegate?.goToFlow2Step2TireTypes()
                    return
                }
                self.coordinatorDelegate?.goToFlow1Step2NewTire()
            }
            
            if let error = error {
                self.delegate?.showError(title: Strings.errorTitle,
                                         message: error.message)
            }
        }
        //
    }
    
    func getTire() {
        Loading.shared.show()
        APIService.getTire { [weak self] model, error in
            Loading.shared.hide()
            guard let self = self else { return }
            
            if let model = model, model.count > 0 {
                self.tire = model[0]
                self.delegate?.setTire()
            }
            if let error = error {
                self.delegate?.showError(title: Strings.errorTitle,
                                         message: error.message)
            }
        }
    }
    
    func goToFlow3Step2Damage() {
        coordinatorDelegate?.goToFlow3Step2Damage()
    }
    
    func goToServiceDetail() {
        if let appointment {
            var support = TireSupportType.none
            if appointment.recordType == .tireChange {
                support = .change
            }
            
            if appointment.recordType == .maintenance {
                support = .damage
            }
            print(support)
//            coordinatorDelegate?.goToServiceDetail(service: nil, appointment: appointment, tireSupportType: support)
        }
    }
    
    func goToLastikChange() {
//        coordinatorDelegate?.goToLastikChange()
    }
}
