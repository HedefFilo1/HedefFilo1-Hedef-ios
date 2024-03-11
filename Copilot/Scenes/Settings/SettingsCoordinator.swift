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
   
    lazy var navigationController: UINavigationController = {
        let navVC = UINavigationController()
        return navVC
    }()
    
    let storyboard = UIStoryboard(storyboard: .settings)
    weak var delegate: AccidentCoordinatorDelegate?
    
    init(delegate: AccidentCoordinatorDelegate? = nil) {
        self.delegate = delegate
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
                               NotificationSettingsVMCrdinatorDelegate {
    func getBack() {
        navigationController.popViewController(animated: true)
    }
    
    func goToNotificationSettings() {
        let controller: NotificationSettingsViewController = storyboard.instantiateViewController()
        controller.viewModel = NotificationSettingsViewModel()
        controller.viewModel.coordinatorDelegate = self
        navigationController.pushViewController(controller, animated: true)
    }
}
