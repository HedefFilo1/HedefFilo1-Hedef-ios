//
//  LastikConfirmInfoViewController.swift
//  Copilot
//
//  Created by Jamal on 12/26/23.
//

import Foundation
protocol LastikConfirmInfoVMCoordinatorDelegate: AnyObject {
    func getBack()
    func lastikFromManger()
}

protocol LastikConfirmInfoViewModelDelegate: AnyObject {
    
}

protocol LastikConfirmInfoViewModelType: AnyObject {
    var coordinatorDelegate: LastikConfirmInfoVMCoordinatorDelegate? { get set }
    var delegate: LastikConfirmInfoViewModelDelegate? { get set }
    
    func getBack()
    func lastikFromManger()
}

class LastikConfirmInfoViewModel: LastikConfirmInfoViewModelType {
    
    weak var coordinatorDelegate: LastikConfirmInfoVMCoordinatorDelegate?
    weak var delegate: LastikConfirmInfoViewModelDelegate?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func lastikFromManger() {
        coordinatorDelegate?.lastikFromManger()
    }
}
