//
//  NotificationCoordinator.swift
//  Copilot
//
//  Created by Jamal on 3/27/24.
//

import Foundation
import UIKit

protocol NotificationCoordinatorDelegate: AnyObject {
    func didFinish(from coordinator: Coordinator)
}

class NotificationCoordinator: Coordinator {
    
    let navigationController: UINavigationController
    let storyboard = UIStoryboard(storyboard: .notification)
    weak var delegate: NotificationCoordinatorDelegate?
    
    init(navigationController: UINavigationController, delegate: NotificationCoordinatorDelegate? = nil) {
        self.navigationController = navigationController
        self.delegate = delegate
    }
    
    func start(appointment: Case?) {
//        let viewController: NotificationViewController = storyboard.instantiateViewController()
//        viewController.viewModel = NotificationViewModel()
//        viewController.viewModel.coordinatorDelegate = self
//        viewController.viewModel.appointment = appointment
//        navigationController.pushViewController(viewController, animated: true)
    }
    
    override func finish() {
        delegate?.didFinish(from: self)
    }
}
