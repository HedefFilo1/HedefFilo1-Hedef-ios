//
//  SettingsCoordinator.swift
//  Copilot
//
//  Created by Jamal on 3/10/24.
//

import Foundation
import UIKit

protocol SettingsCoordinatorDelegate: AnyObject {
    func didFinish(from coordinator: Coordinator)
}

class SettingsCoordinator: Coordinator {
   
    let navigationController: UINavigationController
    
    let storyboard = UIStoryboard(storyboard: .settings)
    weak var delegate: SettingsCoordinatorDelegate?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() {
        let viewController: SettingsViewController = storyboard.instantiateViewController()
        viewController.viewModel = SettingsViewModel()
        viewController.viewModel.coordinatorDelegate = self
        navigationController.navigationBar.isHidden = true
        navigationController.setViewControllers([viewController], animated: true)
    }
    
    override func finish() {
        delegate?.didFinish(from: self)
    }
}

extension SettingsCoordinator: SettingsViewModelCoordinatorDelegate,
                               NotificationSettingsVMCrdinatorDelegate,
                               ContractAgreementVMCrdinatorDelegate {
    func getBack() {
        navigationController.popViewController(animated: true)
    }
    
    func goToNotificationSettings() {
        let controller: NotificationSettingsViewController = storyboard.instantiateViewController()
        controller.viewModel = NotificationSettingsViewModel()
        controller.viewModel.coordinatorDelegate = self
        navigationController.pushViewController(controller, animated: true)
    }
    
    func goToAgreement() {
        let controller: ContractAgreementViewController = storyboard.instantiateViewController()
        controller.viewModel = ContractAgreementViewModel()
        controller.viewModel.coordinatorDelegate = self
        navigationController.pushViewController(controller, animated: true)
    }
}
