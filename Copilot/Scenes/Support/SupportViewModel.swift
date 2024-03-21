//
//  SupportViewModel.swift
//  Copilot
//
//  Created by Fikri Can Cankurtaran on 8.03.2024.
//

import Foundation
 
enum SupportMenuItems: CaseIterable {
    case guides
    case feedback
    case faq
    
    var title: String {
        switch self {
        case .guides:
            Strings.supportGuidesMenuTitle
        case .feedback:
            Strings.supportFeedbackMenuTitle
        case .faq:
            Strings.frequentlyAskedQuestions
        }
    }
}

protocol SupportViewModelCoordinatorDelegate: AnyObject {
    func supportDidFinish()
    func goToFAQ()
    func goToSupportGuide()
    func goToFeedback()
    func goToLiveSupport()
}

protocol SupportViewModelViewDelegate: AnyObject {

}

protocol SupportViewModelType: AnyObject {
    var viewDelegate: SupportViewModelViewDelegate? { get set }
    var coordinatorDelegate: SupportViewModelCoordinatorDelegate? { get set }
    
    func start()
    func finish()
    
    func numberOfItems() -> Int
    func title(for item: Int) -> String
    func goToFAQ()
    func goToSupportGuide()
    func goToFeedback()
    func goToLiveSupport()
}

class SupportViewModel: SupportViewModelType {
    
    // MARK: - Delegates
    weak var coordinatorDelegate: SupportViewModelCoordinatorDelegate?
    weak var viewDelegate: SupportViewModelViewDelegate?
    
    private let items: [SupportMenuItems] = SupportMenuItems.allCases
        
    func start() {
        
    }
    
    func finish() {
        coordinatorDelegate?.supportDidFinish()
    }
    
    func numberOfItems() -> Int {
        items.count
    }
    
    func title(for item: Int) -> String {
        items[item].title
    }
    
    func goToFAQ() {
        coordinatorDelegate?.goToFAQ()
    }
    
    func goToSupportGuide() {
        coordinatorDelegate?.goToSupportGuide()
    }
    
    func goToFeedback() {
        coordinatorDelegate?.goToFeedback()
    }
    
    func goToLiveSupport() {
        coordinatorDelegate?.goToLiveSupport()
    }
}
