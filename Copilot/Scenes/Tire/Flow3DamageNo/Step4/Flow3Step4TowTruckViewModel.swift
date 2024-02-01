//
//  Flow3Step4TowTruckViewModel.swift
//  Copilot
//
//  Created by Jamal on 1/29/24.
//

import Foundation

protocol Flow3Step4TowTruckVMCoordinatorDelegate: AnyObject {
    func getBack()
    func goToServices(tireSupportType: TireSupportType, towTruck: Bool)
}

protocol Flow3Step4TowTruckViewModelDelegate: AnyObject {
    
}

protocol Flow3Step4TowTruckViewModelType: AnyObject {
    var coordinatorDelegate: Flow3Step4TowTruckVMCoordinatorDelegate? { get set }
    var delegate: Flow3Step4TowTruckViewModelDelegate? { get set }
    
    func getBack()
    func goToServices()
}

class Flow3Step4TowTruckViewModel: Flow3Step4TowTruckViewModelType {
    
    weak var coordinatorDelegate: Flow3Step4TowTruckVMCoordinatorDelegate?
    weak var delegate: Flow3Step4TowTruckViewModelDelegate?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func goToServices() {
        coordinatorDelegate?.goToServices(tireSupportType: .damage, towTruck: true)
    }
}
