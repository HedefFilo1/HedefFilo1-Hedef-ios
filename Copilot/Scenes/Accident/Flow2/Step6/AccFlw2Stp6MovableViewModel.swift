//
//  AccFlw2Stp6MovableViewModel.swift
//  Copilot
//
//  Created by Jamal on 2/18/24.
//

import Foundation

protocol AccFlw2Stp6MovableVMCrdinatorDlgt: AnyObject {
    func getBack()
    func goToServices(towTruck: Bool)
}

protocol AccFlw2Stp6MovableViewModelDelegate: BaseViewModelDelegate {
    
}

protocol AccFlw2Stp6MovableViewModelType: AnyObject {
    var coordinatorDelegate: AccFlw2Stp6MovableVMCrdinatorDlgt? { get set }
    var delegate: AccFlw2Stp6MovableViewModelDelegate? { get set }
    func getBack()
    func goToServices()
}

class AccFlw2Stp6MovableViewModel: AccFlw2Stp6MovableViewModelType {
    
    weak var coordinatorDelegate: AccFlw2Stp6MovableVMCrdinatorDlgt?
    weak var delegate: AccFlw2Stp6MovableViewModelDelegate?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func goToServices() {
        coordinatorDelegate?.goToServices(towTruck: false)
    }
    
}
