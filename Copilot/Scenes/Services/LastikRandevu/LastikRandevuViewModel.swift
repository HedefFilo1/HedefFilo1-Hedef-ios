//
//  LastikRandevuViewModel.swift
//  Copilot
//
//  Created by Jamal on 12/25/23.
//

import Foundation

protocol LastikRandevuVMCoordinatorDelegate: AnyObject {
    func getBack()
    func lastikFromManger()
}

protocol LastikRandevuViewModelDelegate: AnyObject {
    
}

protocol LastikRandevuViewModelType: AnyObject {
    var coordinatorDelegate: LastikRandevuVMCoordinatorDelegate? { get set }
    var delegate: LastikRandevuViewModelDelegate? { get set }
    
    func getBack()
    func lastikFromManger()
}

class LastikRandevuViewModel: LastikRandevuViewModelType {
    
    weak var coordinatorDelegate: LastikRandevuVMCoordinatorDelegate?
    weak var delegate: LastikRandevuViewModelDelegate?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func lastikFromManger() {
        coordinatorDelegate?.lastikFromManger()
    }
}
