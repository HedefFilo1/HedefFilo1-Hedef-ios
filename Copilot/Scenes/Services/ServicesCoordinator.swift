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
    
    func goToLastikOperations(appointment: Case?) {
        let coordinator = TireCoordinator(navigationController: navigationController, delegate: self)
        addChildCoordinator(coordinator)
        coordinator.start(appointment: appointment)
    }
    
    func goToMiantenance(appointment: Case?) {
        let coordinator = MaintenanceCoordinator(navigationController: navigationController, delegate: self)
        addChildCoordinator(coordinator)
        coordinator.start(appointment: appointment)
    }
    
    func goToBreakDown(appointment: Case?) {
        let coordinator = BreakDownCoordinator(navigationController: navigationController, delegate: self)
        addChildCoordinator(coordinator)
        coordinator.start(appointment: appointment)
    }
    
    func goToPastServices() {
        let coordinator = PastServicesCoordinator(navigationController: navigationController, delegate: self)
        addChildCoordinator(coordinator)
        coordinator.start()
    }
}

extension ServicesCoordinator {
    
    func getBack() {
        navigationController.popViewController(animated: true)
    }
    
    func getBackToHome() {
        navigationController.popToRootViewController(animated: true)
    }
}

extension ServicesCoordinator: TireCoordinatorDelegate,
                               MaintenanceCoordinatorDelegate,
                               BreakDownCoordinatorDelegate,
                               PastServicesCoordinatorDelegate {
    
    func didFinish(from coordinator: Coordinator) {
        removeChildCoordinator(coordinator)
    }
}
