//
//  ReqFlw2Stp2QuestionsViewModel.swift
//  Copilot
//
//  Created by Jamal on 3/5/24.
//

import Foundation

protocol ReqFlw2Stp2QuestionsViewModelCoordinatorDelegate: AnyObject {
    func getBack()
}

protocol ReqFlw2Stp2QuestionsViewModelDelegate: BaseViewModelDelegate {
    
}

protocol ReqFlw2Stp2QuestionsViewModelType: AnyObject {
    var coordinatorDelegate: ReqFlw2Stp2QuestionsViewModelCoordinatorDelegate? { get set }
    var delegate: ReqFlw2Stp2QuestionsViewModelDelegate? { get set }
    func getBack()
}

class ReqFlw2Stp2QuestionsViewModel: ReqFlw2Stp2QuestionsViewModelType {
    
    weak var coordinatorDelegate: ReqFlw2Stp2QuestionsViewModelCoordinatorDelegate?
    weak var delegate: ReqFlw2Stp2QuestionsViewModelDelegate?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
}
