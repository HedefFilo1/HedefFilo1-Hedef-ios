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
    
    func goToFlow1BreakDownStep2TowTruck() {
        let controller: BrkdwnFlw1Stp2TowTruckVController = storyboard.instantiateViewController()
        controller.viewModel = BrkdwnFlw1Stp2TowTruckViewModel()
        controller.viewModel.coordinatorDelegate = self
        navigationController.pushViewController(controller, animated: true)
    }
}

extension BreakDownCoordinator: BrkdwnFlw1Stp2TowTruckVMCrdinatorDlgt,
                                BrkdwnFlw1Stp3SelectServiceVMCrdintrDlgt {
    
    func goToBrkdwnFlw1Stp3SelectService() {
        let controller: BrkdwnFlw1Stp3SelectServiceVController = storyboard.instantiateViewController()
        controller.viewModel = BrkdwnFlw1Stp3SelectServiceViewModel()
        controller.viewModel.coordinatorDelegate = self
        navigationController.pushViewController(controller, animated: true)
    }
    
    func goToServices() {
        let viewController: BrkdwnFlw1Stp2ServicesVController = storyboard.instantiateViewController()
        viewController.viewModel = ServicesViewModel()
//        viewController.viewModel.coordinatorDelegate = self
        viewController.viewModel.towTruck = false
        navigationController.pushViewController(viewController, animated: true)
    }
}

