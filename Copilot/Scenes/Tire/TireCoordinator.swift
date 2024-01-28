//
//  TireCoordinator.swift
//  Copilot
//
//  Created by Jamal on 1/28/24.
//

import Foundation
import UIKit

protocol TireCoordinatorDelegate: AnyObject {
    func didFinish(from coordinator: Coordinator)
}

class TireCoordinator: Coordinator {
    
    let navigationController: UINavigationController
    let storyboard = UIStoryboard(storyboard: .tire)
    weak var delegate: TireCoordinatorDelegate?
    
    init(navigationController: UINavigationController, delegate: TireCoordinatorDelegate? = nil) {
        self.navigationController = navigationController
        self.delegate = delegate
    }
    
    func start(appointment: Case?) {
        let viewController: TireOperationsViewController = storyboard.instantiateViewController()
        viewController.viewModel = TireOperationsViewModel()
//        viewController.viewModel.coordinatorDelegate = self
        viewController.viewModel.appointment = appointment
        navigationController.pushViewController(viewController, animated: true)
    }
    
    override func finish() {
        delegate?.didFinish(from: self)
    }
}
