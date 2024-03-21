//
//  LiveSupportViewModel.swift
//  Copilot
//
//  Created by Jamal on 3/22/24.
//

import Foundation

protocol LiveSupportViewModelCoordinatorDelegate: AnyObject {
    func getBack()
 
}

protocol LiveSupportViewModelDelegate: AnyObject {

}

protocol LiveSupportViewModelType: AnyObject {
    var delegate: LiveSupportViewModelDelegate? { get set }
    var coordinatorDelegate: LiveSupportViewModelCoordinatorDelegate? { get set }
    func getBack()
}

class LiveSupportViewModel: LiveSupportViewModelType {
    
    // MARK: - Delegates
    weak var coordinatorDelegate: LiveSupportViewModelCoordinatorDelegate?
    weak var delegate: LiveSupportViewModelDelegate?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
}
