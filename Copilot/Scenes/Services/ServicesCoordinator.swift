//
//  ServicesCoordinator.swift
//  Copilot
//
//  Created by Jamal on 12/19/23.
//

import Foundation
import UIKit

protocol ServicesCoordinatorDelegate: AnyObject {
    func didFinish(from coordinator: Coordinator)
}

class ServicesCoordinator: Coordinator {
    
    lazy var navigationController: UINavigationController = {
        let navVC = UINavigationController()
        return navVC
    }()
    
    let storyboard = UIStoryboard(storyboard: .services)
    weak var delegate: ServicesCoordinatorDelegate?
    
    override func start() {
        let viewController: ServiceTabViewController = storyboard.instantiateViewController()
        viewController.viewModel = ServiceTabViewModel()
        viewController.viewModel.coordinatorDelegate = self
        navigationController.navigationBar.isHidden = true
        navigationController.setViewControllers([viewController], animated: true)
    }
    
    override func finish() {
        delegate?.didFinish(from: self)
    }
}

extension ServicesCoordinator: ServiceTabViewModelCoordinatorDelegate {
    func goToLastikOperations() {
        let viewController: LastikOperationsViewController = storyboard.instantiateViewController()
        viewController.viewModel = LastikOperationsViewModel()
        viewController.viewModel.coordinatorDelegate = self
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension ServicesCoordinator: LastikOperationsVMCoordinatorDelegate {
    func goToRequestNewLastik() {
        let viewController: NewLastikRequestViewController = storyboard.instantiateViewController()
        viewController.viewModel = NewLastikRequestViewModel()
        viewController.viewModel.coordinatorDelegate = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func getBack() {
        navigationController.popViewController(animated: true)
    }
}

extension ServicesCoordinator: NewLastikRequestVMCoordinatorDelegate {
    
}
