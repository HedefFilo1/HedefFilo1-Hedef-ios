//
//  ReqFlw2Stp2QuestionsViewModel.swift
//  Copilot
//
//  Created by Jamal on 3/5/24.
//

import Foundation

protocol ReqFlw2Stp2QuestionsVMCoordinatorDelegate: AnyObject {
    func getBack()
    func goToReqFlw2Stp3Vehicle()
}

protocol ReqFlw2Stp2QuestionsViewModelDelegate: BaseViewModelDelegate {
    
}

protocol ReqFlw2Stp2QuestionsViewModelType: AnyObject {
    var coordinatorDelegate: ReqFlw2Stp2QuestionsVMCoordinatorDelegate? { get set }
    var delegate: ReqFlw2Stp2QuestionsViewModelDelegate? { get set }
    func getBack()
    func goToReqFlw2Stp3Vehicle()
}

class ReqFlw2Stp2QuestionsViewModel: ReqFlw2Stp2QuestionsViewModelType {
    
    weak var coordinatorDelegate: ReqFlw2Stp2QuestionsVMCoordinatorDelegate?
    weak var delegate: ReqFlw2Stp2QuestionsViewModelDelegate?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func goToReqFlw2Stp3Vehicle() {
        coordinatorDelegate?.goToReqFlw2Stp3Vehicle()
    }
}
