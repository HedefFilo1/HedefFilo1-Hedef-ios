//
//  ReqFlw2Stp2QuestionsViewModel.swift
//  Copilot
//
//  Created by Jamal on 3/5/24.
//

import Foundation

protocol ReqFlw2Stp2QuestionsVMCrdintrDelegate: AnyObject {
    func getBack()
    func goToReqFlw2Stp3Vehicle()
    func goToReqFlw3Stp3HGS()
}

protocol ReqFlw2Stp2QuestionsViewModelDelegate: BaseViewModelDelegate {
    
}

protocol ReqFlw2Stp2QuestionsViewModelType: AnyObject {
    var coordinatorDelegate: ReqFlw2Stp2QuestionsVMCrdintrDelegate? { get set }
    var delegate: ReqFlw2Stp2QuestionsViewModelDelegate? { get set }
    func getBack()
    func goToReqFlw2Stp3Vehicle()
    func goToReqFlw3Stp3HGS()
}

class ReqFlw2Stp2QuestionsViewModel: ReqFlw2Stp2QuestionsViewModelType {
    
    weak var coordinatorDelegate: ReqFlw2Stp2QuestionsVMCrdintrDelegate?
    weak var delegate: ReqFlw2Stp2QuestionsViewModelDelegate?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func goToReqFlw2Stp3Vehicle() {
        coordinatorDelegate?.goToReqFlw2Stp3Vehicle()
    }
    
    func goToReqFlw3Stp3HGS() {
        coordinatorDelegate?.goToReqFlw3Stp3HGS()
    }
}
