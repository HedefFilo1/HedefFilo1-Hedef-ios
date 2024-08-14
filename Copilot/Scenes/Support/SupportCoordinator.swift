//
//  SupportCoordinator.swift
//  Copilot
//
//  Created by Fikri Can Cankurtaran on 8.03.2024.
//

import Foundation
import UIKit

protocol SupportCoordinatorDelegate: AnyObject {
    func supportDidFinish(from coordinator: SupportCoordinator)
}

class SupportCoordinator: Coordinator {
    
    lazy var navigationController: UINavigationController = {
        let navVC = UINavigationController()
        navVC.isNavigationBarHidden = true
        return navVC
    }()
    
    let storyboard = UIStoryboard(storyboard: .support)
    
    weak var delegate: SupportCoordinatorDelegate?
    
    lazy var feedbackRateNavigation = UINavigationController()
    
    private lazy var supportViewModel: SupportViewModel = {
        let viewModel = SupportViewModel()
        viewModel.coordinatorDelegate = self
        return viewModel
    }()
    
    override func start() {
        let viewController: SupportViewController = storyboard.instantiateViewController()
        viewController.viewModel = supportViewModel
        navigationController.setViewControllers([viewController], animated: true)
    }
    
    override func finish() {
        delegate?.supportDidFinish(from: self)
    }
    
    func goToNotifications() {
        let controller: NotificationsViewController = UIStoryboard(storyboard: .notification).instantiateViewController()
        controller.viewModel = NotificationsViewModel()
//        controller.viewModel.coordinatorDelegate = self
        navigationController.pushViewController(controller, animated: true)
    }
    
}

extension SupportCoordinator: SupportViewModelCoordinatorDelegate,
                              FAQVMCrdinatorDlgt,
                              FAQQuestionVMCrdinatorDlgt,
                              FAQQuestionDetailVMCrdinatorDlgt,
                              SupportGuideVMCrdinatorDlgt,
                              SupportGuideDetailVMCrdinatorDlgt,
                              FeedbackViewModelCoordinatorDelegate,
                              LiveSupportViewModelCoordinatorDelegate,
                              ServiceOperationsVMCoordinatorDelegate,
                              ProccessRequestsVMCoordinatorDelegate {
    func getBack() {
        navigationController.popViewController(animated: true)
    }
    
    func supportDidFinish() {
        finish()
    }
    
    func goToFAQ() {
        let controller: FAQViewController = storyboard.instantiateViewController()
        controller.viewModel = FAQViewModel()
        controller.viewModel.coordinatorDelegate = self
        navigationController.pushViewController(controller, animated: true)
    }
    
    func goToFAQQuestion(item: FAQQuestion) {
        let controller: FAQQeustionViewController = storyboard.instantiateViewController()
        controller.viewModel = FAQQuestionViewModel()
        controller.viewModel.coordinatorDelegate = self
        controller.viewModel.item = item
        navigationController.pushViewController(controller, animated: true)
    }
    
    func goToFAQQuestionDetail(item: FAQQuestionDetail) {
        let controller: FAQQuestionDetailViewController = storyboard.instantiateViewController()
        controller.viewModel = FAQQuestionDetailViewModel()
        controller.viewModel.coordinatorDelegate = self
        controller.viewModel.item = item
        navigationController.pushViewController(controller, animated: true)
    }
    
    func goToSupportGuide() {
        let controller: SupportGuideViewController = storyboard.instantiateViewController()
        controller.viewModel = SupportGuideViewModel()
        controller.viewModel.coordinatorDelegate = self
        navigationController.pushViewController(controller, animated: true)
    }
    
    func goToSupportGuideDetail(item: SupportGuide) {
        let controller: SupportGuideDetailViewController = storyboard.instantiateViewController()
        controller.viewModel = SupportGuideDetailViewModel()
        controller.viewModel.coordinatorDelegate = self
        controller.viewModel.item = item
        navigationController.pushViewController(controller, animated: true)
    }
    
    func goToFeedback() {
        let controller: FeedbackViewController = storyboard.instantiateViewController()
        controller.viewModel = FeedbackViewModel()
        controller.viewModel.coordinatorDelegate = self
        navigationController.pushViewController(controller, animated: true)
    }
    
    func goToLiveSupport() {
        let controller: LiveSupportViewController = storyboard.instantiateViewController()
        controller.viewModel = LiveSupportViewModel()
        controller.viewModel.coordinatorDelegate = self
        navigationController.pushViewController(controller, animated: true)
    }
    
    func goToServiceOperations() {
        let controller: ServiceOperationsViewController = storyboard.instantiateViewController()
        controller.viewModel = ServiceOperationsViewModel()
        controller.viewModel.coordinatorDelegate = self
        navigationController.pushViewController(controller, animated: true)
    }
    
    func goToProccessRequests() {
        let controller: ProccessRequestsViewController = storyboard.instantiateViewController()
        controller.viewModel = ProccessRequestsViewModel()
        controller.viewModel.coordinatorDelegate = self
        navigationController.pushViewController(controller, animated: true)
    }
    
}

// MARK: Presentations, Rate and comment
extension SupportCoordinator: UIViewControllerTransitioningDelegate,
                              FeedbackRateVMCoordinatorDelegate, FeedbackCommentVMCoordinatorDelegate {
    
    func presentFitlers(title: String,
                        delegate: FeedbackFilterViewControllerDelegate,
                        items: [FeedbackFilterItem]) {
        let controller: FeedbackFilterViewController = storyboard.instantiateViewController()
        let viewModel = FeedbackFilterViewModel()
        controller.viewModel = viewModel
        viewModel.items = items
        controller.delegate = delegate
        viewModel.title = title
        navigationController.present(controller, animated: true)
    }
    
    func presentFeedbackRate(caseId: String, date: String, description: String) {
        let controller: FeedbackRateViewController = storyboard.instantiateViewController()
        let viewModel = FeedbackRateViewModel()
        controller.viewModel = viewModel
        viewModel.caseId = caseId
        viewModel.date = date
        viewModel.description = description
        viewModel.coordinatorDelegate = self
        //        navigationController.present(controller, animated: true)
        
        feedbackRateNavigation.viewControllers = [controller]
        feedbackRateNavigation.isNavigationBarHidden = true
        feedbackRateNavigation.modalPresentationStyle = .custom
        feedbackRateNavigation.transitioningDelegate = self
        navigationController.present(feedbackRateNavigation, animated: true)
    }
    
    func goToFeedbackComment(caseId: String, rate: Int) {
        let controller: FeedbackCommentViewController = storyboard.instantiateViewController()
        let viewModel = FeedbackCommentViewModel()
        controller.viewModel = viewModel
        viewModel.coordinatorDelegate = self
        controller.modalPresentationStyle = .custom
        controller.transitioningDelegate = self
        viewModel.caseId = caseId
        viewModel.rate = rate
        navigationController.present(controller, animated: true)
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let controller = FeedbackRatePresentationController(presentedViewController: presented, presenting: presenting)
        return controller
    }
    
    func getBackFromFeedbackComment() {
        feedbackRateNavigation.popViewController(animated: true)
    }
}
