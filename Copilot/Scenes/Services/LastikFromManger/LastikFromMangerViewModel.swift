//
//  LastikFromMangerViewModel.swift
//  Copilot
//
//  Created by Jamal on 12/25/23.
//

import Foundation

protocol LastikFromMangerVMCoordinatorDelegate: AnyObject {
    func getBack()
    func goToRequestLastikResult()
}

protocol LastikFromMangerViewModelDelegate: AnyObject {
    
}

protocol LastikFromMangerViewModelType: AnyObject {
    var coordinatorDelegate: LastikFromMangerVMCoordinatorDelegate? { get set }
    var delegate: LastikFromMangerViewModelDelegate? { get set }
    
    func getBack()
    func goToRequestLastikResult()
}

class LastikFromMangerViewModel: LastikFromMangerViewModelType {
    
    weak var coordinatorDelegate: LastikFromMangerVMCoordinatorDelegate?
    weak var delegate: LastikFromMangerViewModelDelegate?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func goToRequestLastikResult() {
        coordinatorDelegate?.goToRequestLastikResult()
    }
}
