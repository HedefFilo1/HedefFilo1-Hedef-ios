//
//  ProfileCoordinator.swift
//  Copilot
//
//  Created by Jamal on 10/13/23.
//

import Foundation
import UIKit

protocol ProfileCoordinatorDelegate: AnyObject {
    func didFinish(from coordinator: Coordinator)
}

class ProfileCoordinator: Coordinator {
    
    lazy var navigationController: UINavigationController = {
        let navVC = UINavigationController()
        return navVC
    }()
    
    let storyboard = UIStoryboard(storyboard: .profile)
    weak var delegate: ProfileCoordinatorDelegate?
    
    var profileViewModel: ProfileViewModel {
        let viewModel = ProfileViewModel()
        viewModel.coordinatorDelegate = self
        return viewModel
    }
    
    override func start() {
        let viewController: ProfileViewController = storyboard.instantiateViewController()
        viewController.viewModel = profileViewModel
        navigationController.setViewControllers([viewController], animated: true)
    }
    
    override func finish() {
        delegate?.didFinish(from: self)
    }
    
}

extension ProfileCoordinator: ProfileViewModelCoordinatorDelegate {
    
    func goToResetPassword() {
        let viewController: PasswordResetViewController = storyboard.instantiateViewController()
        let viewModel = PasswordResetViewModel()
        viewController.viewModel = viewModel
        viewModel.coordinatorDelegate = self
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension ProfileCoordinator: PasswordResetVMCoordinatorDelegate {
    func getBack() {
        navigationController.popViewController(animated: true)
    }
}

extension ProfileCoordinator {
    func didFinish(from coordinator: Coordinator) {
        removeChildCoordinator(coordinator)
    }
}
