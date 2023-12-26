//
//  LastikConfirmInfoViewController.swift
//  Copilot
//
//  Created by Jamal on 12/26/23.
//

import Foundation
protocol LastikConfirmInfoVMCoordinatorDelegate: AnyObject {
    func getBack()
    func goToServices()
}

protocol LastikConfirmInfoViewModelDelegate: AnyObject {
    
}

protocol LastikConfirmInfoViewModelType: AnyObject {
    var coordinatorDelegate: LastikConfirmInfoVMCoordinatorDelegate? { get set }
    var delegate: LastikConfirmInfoViewModelDelegate? { get set }
    
    func getBack()
    func goToServices()
}

class LastikConfirmInfoViewModel: LastikConfirmInfoViewModelType {
    
    weak var coordinatorDelegate: LastikConfirmInfoVMCoordinatorDelegate?
    weak var delegate: LastikConfirmInfoViewModelDelegate?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func goToServices() {
        coordinatorDelegate?.goToServices()
    }
}
