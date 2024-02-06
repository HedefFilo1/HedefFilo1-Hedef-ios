//
//  BreakDownCoordinator.swift
//  Copilot
//
//  Created by Jamal on 1/31/24.
//

import Foundation
import UIKit

protocol BreakDownCoordinatorDelegate: AnyObject {
    func didFinish(from coordinator: Coordinator)
}

class BreakDownCoordinator: Coordinator {
    
    let navigationController: UINavigationController
    let storyboard = UIStoryboard(storyboard: .breakDown)
    weak var delegate: BreakDownCoordinatorDelegate?
    
    init(navigationController: UINavigationController, delegate: BreakDownCoordinatorDelegate? = nil) {
        self.navigationController = navigationController
        self.delegate = delegate
    }
    
    override func start() {
        let viewController: BreakDownViewController = storyboard.instantiateViewController()
        viewController.viewModel = BreakDownViewModel()
        viewController.viewModel.coordinatorDelegate = self
//        viewController.viewModel.appointment = appointment
        navigationController.pushViewController(viewController, animated: true)
    }
    
    override func finish() {
        delegate?.didFinish(from: self)
    }
}

extension BreakDownCoordinator: BreakDownVMCoordinatorDelegate,
                                BreakdownStep2VMCoordinatorDelegate {
    func getBack() {
        navigationController.popViewController(animated: true)
    }
    
    func getBackToHome() {
        self.navigationController.select(tab: 2)
        navigationController.popToRootViewController(animated: true)
    }
    
    func goToBreakDownStep2TowTruck() {
        let controller: BrkdwnFlw1Stp2TowTruckVController = storyboard.instantiateViewController()
        controller.viewModel = BrkdwnFlw1Stp2TowTruckViewModel()
        controller.viewModel.coordinatorDelegate = self
        navigationController.pushViewController(controller, animated: true)
    }
}

extension BreakDownCoordinator: BrkdwnFlw1Stp2TowTruckVMCrdinatorDlgt {
    func goToBrkdwnFlw1Stp2SelectService() {
        let controller: BrkdwnFlw1Stp2SelectServiceVController = storyboard.instantiateViewController()
        controller.viewModel = BrkdwnFlw1Stp2SelectServiceViewModel()
//        controller.viewModel.coordinatorDelegate = self
        navigationController.pushViewController(controller, animated: true)
    }
}
