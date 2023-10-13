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
    
    let navigationController: UINavigationController
    let storyboard = UIStoryboard(storyboard: .profile)
    weak var delegate: ProfileCoordinatorDelegate?
    
    var profileViewModel: ProfileViewModel {
        let viewModel = ProfileViewModel()
        viewModel.coordinatorDelegate = self
        return viewModel
    }
    
    init(with navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() {
        
    }
    
    override func finish() {
        delegate?.didFinish(from: self)
    }
    
}

extension ProfileCoordinator: ProfileViewModelCoordinatorDelegate {
    func goToResetPassword() {
        
    }
}

extension ProfileCoordinator {
    func didFinish(from coordinator: Coordinator) {
        removeChildCoordinator(coordinator)
    }
}
