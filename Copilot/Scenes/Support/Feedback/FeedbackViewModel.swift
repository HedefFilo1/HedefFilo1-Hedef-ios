//
//  FeedbackViewModel.swift
//  Copilot
//
//  Created by Jamal on 3/21/24.
//

import Foundation

enum FeedbackItems: CaseIterable {
    case processRequests
    case service
    
    var title: String {
        switch self {
        case .processRequests:
            Strings.processRequests
        case .service:
            Strings.serviceOperations
        }
    }
}

protocol FeedbackViewModelCoordinatorDelegate: AnyObject {
    func getBack()
    func goToServiceOperations()
}

protocol FeedbackViewModelViewDelegate: AnyObject {

}

protocol FeedbackViewModelType: AnyObject {
    var viewDelegate: FeedbackViewModelViewDelegate? { get set }
    var coordinatorDelegate: FeedbackViewModelCoordinatorDelegate? { get set }
    var items: [FeedbackItems] { get set }
    func getBack()
    func goToServiceOperations()
}

class FeedbackViewModel: FeedbackViewModelType {
    
    // MARK: - Delegates
    weak var coordinatorDelegate: FeedbackViewModelCoordinatorDelegate?
    weak var viewDelegate: FeedbackViewModelViewDelegate?
    
    var items: [FeedbackItems] = FeedbackItems.allCases
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func goToServiceOperations() {
        coordinatorDelegate?.goToServiceOperations()
    }
}
