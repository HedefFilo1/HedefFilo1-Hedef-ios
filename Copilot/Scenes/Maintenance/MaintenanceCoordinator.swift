//
//  MaintenanceCoordinator.swift
//  Copilot
//
//  Created by Jamal on 1/30/24.
//

import Foundation
import UIKit

protocol MaintenanceCoordinatorDelegate: AnyObject {
    func didFinish(from coordinator: Coordinator)
}

class MaintenanceCoordinator: Coordinator {
    
    let navigationController: UINavigationController
    let storyboard = UIStoryboard(storyboard: .maintenance)
    weak var delegate: MaintenanceCoordinatorDelegate?
    
    init(navigationController: UINavigationController, delegate: MaintenanceCoordinatorDelegate? = nil) {
        self.navigationController = navigationController
        self.delegate = delegate
    }
    
    func start(appointment: Case?) {
        let viewController: MaintenanceViewController = storyboard.instantiateViewController()
        viewController.viewModel = MaintenanceViewModel()
        viewController.viewModel.coordinatorDelegate = self
        viewController.viewModel.appointment = appointment
        navigationController.pushViewController(viewController, animated: true)
    }
    
    override func finish() {
        delegate?.didFinish(from: self)
    }
}

extension MaintenanceCoordinator: MaintenanceVMCoordinatorDelegate {
    
    func getBack() {
        navigationController.popViewController(animated: true)
    }
    
    func getBackToHome() {
        self.navigationController.select(tab: 2)
        navigationController.popToRootViewController(animated: true)
    }
    
    func goToMaintenanceStep2KM() {
        let controller: MaintenanceStep2KMViewController = storyboard.instantiateViewController()
        controller.viewModel = MaintenanceStep2KMViewModel()
        controller.viewModel.coordinatorDelegate = self
        navigationController.pushViewController(controller, animated: true)
    }
}

extension MaintenanceCoordinator: MaintenanceStep2KMVMCoordinatorDelegate,
                                  NotMaintenancePeriodVMCoordinatorDelegate {
    func goToNotMaintenancePeriod() {
        let controller: NotMaintenancePeriodViewController = storyboard.instantiateViewController()
        controller.viewModel = NotMaintenancePeriodViewModel()
        controller.viewModel.coordinatorDelegate = self
        navigationController.pushViewController(controller, animated: true)
    }
    
    
}
