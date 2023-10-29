//
//  NearMeViewModel.swift
//  Copilot
//
//  Created by Jamal on 10/29/23.
//

import Foundation

protocol NearMeViewModelCoordinatorDelegate: AnyObject {
 func getBack()
}

protocol NearMeViewModelDelegate: AnyObject {
    
}

protocol NearMeViewModelType: AnyObject {
    var delegate: NearMeViewModelDelegate? { get set }
    func getBack()
}

class NearMeViewModel: NearMeViewModelType {
    
    // MARK: - Delegates
    var coordinatorDelegate: NearMeViewModelCoordinatorDelegate?
    weak var delegate: NearMeViewModelDelegate?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }

}
