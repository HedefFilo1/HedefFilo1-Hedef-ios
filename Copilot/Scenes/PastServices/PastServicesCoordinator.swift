//
//  PastServicesCoordinator.swift
//  Copilot
//
//  Created by Jamal on 3/28/24.
//

import Foundation
import UIKit

protocol PastServicesCoordinatorDelegate: AnyObject {
    func didFinish(from coordinator: Coordinator)
}

class PastServicesCoordinator: Coordinator {
    
    let navigationController: UINavigationController
    let storyboard = UIStoryboard(storyboard: .pastServices)
    weak var delegate: PastServicesCoordinatorDelegate?
    
    init(navigationController: UINavigationController, delegate: PastServicesCoordinatorDelegate? = nil) {
        self.navigationController = navigationController
        self.delegate = delegate
    }
    
    override func start() {
        let page: PageViewController = PageViewController()
        let controller: PastMaintenancesViewController = storyboard.instantiateViewController()
        controller.viewModel = PastMaintenancesViewModel()
        page.setViewControllers([controller], direction: .forward, animated: true)
        controller.viewModel.coordinatorDelegate = self
        navigationController.pushViewController(page, animated: true)
    }
    
    override func finish() {
        delegate?.didFinish(from: self)
    }
}

extension PastServicesCoordinator: PastMaintenancesVMCrdinatorDelegate {
    func getBack() {
        navigationController.popViewController(animated: true)
    }
}
