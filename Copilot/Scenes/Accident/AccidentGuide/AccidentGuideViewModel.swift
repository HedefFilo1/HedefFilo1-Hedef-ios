//
//  AccidentGuideViewModel.swift
//  Copilot
//
//  Created by Jamal on 3/1/24.
//

import Foundation

protocol AccidentGuideViewModelCoordinatorDelegate: AnyObject {
    func getBack()
}

protocol AccidentGuideViewModelDelegate: AnyObject {
    
}

protocol AccidentGuideViewModelType: AnyObject {
    var coordinatorDelegate: AccidentGuideViewModelCoordinatorDelegate? { get set }
    var delegate: AccidentGuideViewModelDelegate? { get set }
    func getBack()
}

class AccidentGuideViewModel: AccidentGuideViewModelType {
    
    weak var coordinatorDelegate: AccidentGuideViewModelCoordinatorDelegate?
    weak var delegate: AccidentGuideViewModelDelegate?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
}
