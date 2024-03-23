//
//  FeedbackRateViewModel.swift
//  Copilot
//
//  Created by Jamal on 3/24/24.
//

import Foundation

protocol FeedbackRateVMCoordinatorDelegate: AnyObject {
    func goToFeedbackComment()
}

protocol FeedbackRateViewModelDelegate: AnyObject {
    
}

protocol FeedbackRateViewModelType: AnyObject {
    var coordinatorDelegate: FeedbackRateVMCoordinatorDelegate? { get set }
    var delegate: FeedbackRateViewModelDelegate? { get set }
    var rate: Int { get set }
    func goToFeedbackComment()
}

class FeedbackRateViewModel: FeedbackRateViewModelType {
    
    weak var coordinatorDelegate: FeedbackRateVMCoordinatorDelegate?
    weak var delegate: FeedbackRateViewModelDelegate?
    var rate: Int = 0

    func goToFeedbackComment() {
        coordinatorDelegate?.goToFeedbackComment()
    }
}
