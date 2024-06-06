//
//  FeedbackCommentViewModel.swift
//  Copilot
//
//  Created by Jamal on 3/24/24.
//

import Foundation

protocol FeedbackCommentVMCoordinatorDelegate: AnyObject {
    func getBackFromFeedbackComment()
}

protocol FeedbackCommentViewModelDelegate: BaseViewModelDelegate {
    func didFinishSendFeedBack()
}

protocol FeedbackCommentViewModelType: AnyObject {
    var coordinatorDelegate: FeedbackCommentVMCoordinatorDelegate? { get set }
    var delegate: FeedbackCommentViewModelDelegate? { get set }
    var rate: Int { get set }
    var caseId: String { get set }
    func getBackFromFeedbackComment()
    func sendFeedBack(comment: String)
}

class FeedbackCommentViewModel: FeedbackCommentViewModelType {
    
    weak var coordinatorDelegate: FeedbackCommentVMCoordinatorDelegate?
    weak var delegate: FeedbackCommentViewModelDelegate?
    var rate: Int = 0
    var caseId = ""
    
    func getBackFromFeedbackComment() {
        coordinatorDelegate?.getBackFromFeedbackComment()
    }
    
    func sendFeedBack(comment: String) {
        Loading.shared.show(presented: true)
        APIService.sendFeedBack(caseId: caseId,
                                rate: rate,
                                comment: comment)
        { [weak self] model, error in
            Loading.shared.hide()
            guard let self = self else { return }
            
            if let error = error {
                self.delegate?.showError(title: Strings.errorTitle,
                                         message: error.message)
                return
            }
                
            self.delegate?.didFinishSendFeedBack()
            
        }
    }
}
