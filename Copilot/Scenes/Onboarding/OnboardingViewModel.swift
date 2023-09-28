//
//  OnboardingViewModel.swift
//  Copilot
//
//  Created by Jamal on 9/28/23.
//

import Foundation

protocol OnboardingViewModelCoordinatorDelegate: AnyObject {
    func goToNextScene()
}

protocol OnboardingViewModelDelegate: AnyObject {
    
}

protocol OnboardingViewModelType: AnyObject {
    var coordinatorDelegate: OnboardingViewModelCoordinatorDelegate? { get set }
    var delegate: OnboardingViewModelDelegate? { get set }
    var currentIndex: Int { get set }
    func goToNextScene()
}

class OnboardingViewModel: OnboardingViewModelType {

    // MARK: - Delegates
    weak var coordinatorDelegate: OnboardingViewModelCoordinatorDelegate?
    weak var delegate: OnboardingViewModelDelegate?
    var currentIndex: Int = 0
    
    func goToNextScene() {
        coordinatorDelegate?.goToNextScene()
    }
}
