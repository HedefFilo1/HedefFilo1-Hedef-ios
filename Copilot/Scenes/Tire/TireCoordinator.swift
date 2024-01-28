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
        viewController.viewModel.coordinatorDelegate = self
        viewController.viewModel.appointment = appointment
        navigationController.pushViewController(viewController, animated: true)
    }
    
    override func finish() {
        delegate?.didFinish(from: self)
    }
}

extension TireCoordinator: TireOperationsVMCoordinatorDelegate,
                           Flow1Step2NewTireVMCoordinatorDelegate,
                           Flow1Step3TireTypesVMCoordinatorDelegate,
                           Flow1Step4ResultVMCoordinatorDelegate {
    
    func getBackToHome() {
        navigationController.popToRootViewController(animated: true)
    }
    
    func goToRequests() {
        
    }
    
    func getBack() {
        navigationController.popViewController(animated: true)
    }
    
    func goToFlow1Step2NewTire() {
        let viewController: Flow1Step2NewTireViewController = storyboard.instantiateViewController()
        viewController.viewModel = Flow1Step2NewTireViewModel()
        viewController.viewModel.coordinatorDelegate = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func goToFlow1Step3TireTypes() {
        let viewController: Flow1Step3TireTypesViewController = storyboard.instantiateViewController()
        viewController.viewModel = Flow1Step3TireTypesViewModel()
        viewController.viewModel.coordinatorDelegate = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func goToFlow1Step4Result() {
        let viewController: Flow1Step4ResultViewController = storyboard.instantiateViewController()
        viewController.viewModel = Flow1Step4ResultViewModel()
        viewController.viewModel.coordinatorDelegate = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func goToFlow2Step2TireTypes() {
        let viewController: Flow1Step3TireTypesViewController = storyboard.instantiateViewController()
        viewController.viewModel = Flow1Step3TireTypesViewModel()
        viewController.viewModel.coordinatorDelegate = self
        navigationController.pushViewController(viewController, animated: true)
    }
}
