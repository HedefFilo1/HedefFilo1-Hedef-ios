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
//        viewController.viewModel.coordinatorDelegate = self
//        viewController.viewModel.appointment = appointment
        navigationController.pushViewController(viewController, animated: true)
    }
    
    override func finish() {
        delegate?.didFinish(from: self)
    }
}
