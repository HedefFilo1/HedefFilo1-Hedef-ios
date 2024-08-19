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
    
    var navigationController: UINavigationController
    
    let storyboard = UIStoryboard(storyboard: .profile)
    weak var delegate: ProfileCoordinatorDelegate?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    var profileViewModel: ProfileViewModel {
        let viewModel = ProfileViewModel()
        viewModel.coordinatorDelegate = self
        return viewModel
    }
    
    override func start() {
        let viewController: ProfileViewController = storyboard.instantiateViewController()
        viewController.viewModel = profileViewModel
        navigationController.pushViewController(viewController, animated: true)
        
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
    
    func presentDeleteAccount() {
        let controller: DeleteAccountViewController = UIStoryboard(storyboard: .profile).instantiateViewController()
        let viewModel = DeleteAccountViewModel()
        viewModel.coordinatorDelegate = self
        controller.viewModel = viewModel
        navigationController.present(controller, animated: true)
    }
}

extension ProfileCoordinator: PasswordResetVMCoordinatorDelegate {
    func getBack() {
        navigationController.popViewController(animated: true)
    }
}

extension ProfileCoordinator: DeleteAccountVMCoordinatorDelegate {
    
}

extension ProfileCoordinator {
    func didFinish(from coordinator: Coordinator) {
        removeChildCoordinator(coordinator)
    }
}
