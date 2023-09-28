//
//  OnboardingCoordinator.swift
//  Copilot
//
//  Created by Jamal on 9/28/23.
//

import Foundation
import UIKit

protocol OnboardingCoordinatorDelegate: AnyObject {
    func goToLogin()
    func didFinish(from coordinator: Coordinator)
}

class OnboardingCoordinator: Coordinator {

    let window: UIWindow
    let navigationController = UINavigationController()
    let storyboard = UIStoryboard(storyboard: .onboarding)

    weak var delegate: OnboardingCoordinatorDelegate?

    var onboardingViewModel: OnboardingViewModel {
        let viewModel = OnboardingViewModel()
        viewModel.coordinatorDelegate = self
        return viewModel
    }

    init(with window: UIWindow) {
        self.window = window
    }

    // MARK: - Coordinator
    override func start() {
        let viewController: OnboardingViewController = storyboard.instantiateViewController()
        viewController.viewModel = onboardingViewModel
        navigationController.viewControllers = [viewController]
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        viewController.viewModel.coordinatorDelegate = self
    }

    override func finish() {
        delegate?.didFinish(from: self)
    }

}

extension OnboardingCoordinator: OnboardingViewModelCoordinatorDelegate {
    
    func goToNextScene() {
        delegate?.goToLogin()
        finish()
    }
}
