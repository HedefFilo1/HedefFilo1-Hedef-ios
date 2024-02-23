//
//  AccFlw1Stp1OtherVehicleOtherVehicleViewModel.swift
//  Copilot
//
//  Created by Jamal on 2/16/24.
//

import Foundation

protocol AccFlw1Stp2OtherVehicleVMCrdinatorDlgt: AnyObject {
    func getBack()
    func goToAccFlw1Stp3Agreement()
    func goToAccFlw5Stp3Declare()
}

protocol AccFlw1Stp2OtherVehicleViewModelDelegate: BaseViewModelDelegate {
    
}

protocol AccFlw1Stp2OtherVehicleViewModelType: AnyObject {
    var coordinatorDelegate: AccFlw1Stp2OtherVehicleVMCrdinatorDlgt? { get set }
    var delegate: AccFlw1Stp2OtherVehicleViewModelDelegate? { get set }
    func getBack()
    func goToAccFlw1Stp3Agreement()
    func goToAccFlw5Stp3Declare()
}

class AccFlw1Stp2OtherVehicleViewModel: AccFlw1Stp2OtherVehicleViewModelType {
    
    weak var coordinatorDelegate: AccFlw1Stp2OtherVehicleVMCrdinatorDlgt?
    weak var delegate: AccFlw1Stp2OtherVehicleViewModelDelegate?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func goToAccFlw1Stp3Agreement() {
        coordinatorDelegate?.goToAccFlw1Stp3Agreement()
    }
    
    func goToAccFlw5Stp3Declare() {
        coordinatorDelegate?.goToAccFlw5Stp3Declare()
    }
}
