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

protocol FeedbackCommentViewModelDelegate: AnyObject {
    
}

protocol FeedbackCommentViewModelType: AnyObject {
    var coordinatorDelegate: FeedbackCommentVMCoordinatorDelegate? { get set }
    var delegate: FeedbackCommentViewModelDelegate? { get set }
    var rate: Int { get set }
    func getBackFromFeedbackComment()
}

class FeedbackCommentViewModel: FeedbackCommentViewModelType {
    
    weak var coordinatorDelegate: FeedbackCommentVMCoordinatorDelegate?
    weak var delegate: FeedbackCommentViewModelDelegate?
    var rate: Int = 0

    func getBackFromFeedbackComment() {
        coordinatorDelegate?.getBackFromFeedbackComment()
    }
}
