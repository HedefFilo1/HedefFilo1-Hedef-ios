//
//  LastikChangeViewModel.swift
//  Copilot
//
//  Created by Jamal on 1/23/24.
//

import Foundation

protocol LastikChangeVMCoordinatorDelegate: AnyObject {
    func getBack()
    func goToServices(tireSupportType: TireSupportType)
}

protocol LastikChangeViewModelDelegate: AnyObject {
    
}

protocol LastikChangeViewModelType: AnyObject {
    var coordinatorDelegate: LastikChangeVMCoordinatorDelegate? { get set }
    var delegate: LastikChangeViewModelDelegate? { get set }
    
    func getBack()
    func goToServices()
}

class LastikChangeViewModel: LastikChangeViewModelType {
    
    weak var coordinatorDelegate: LastikChangeVMCoordinatorDelegate?
    weak var delegate: LastikChangeViewModelDelegate?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func goToServices() {
        coordinatorDelegate?.goToServices(tireSupportType: .change)
    }
}
