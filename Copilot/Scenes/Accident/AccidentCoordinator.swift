//
//  AccidentCoordinator.swift
//  Copilot
//
//  Created by Jamal on 2/16/24.
//

import Foundation
import UIKit

protocol AccidentCoordinatorDelegate: AnyObject {
    func didFinish(from coordinator: Coordinator)
}

class AccidentCoordinator: Coordinator {
    
    lazy var navigationController: UINavigationController = {
        let navVC = UINavigationController()
        return navVC
    }()
    
    let storyboard = UIStoryboard(storyboard: .accident)
    weak var delegate: AccidentCoordinatorDelegate?
    
    init(delegate: AccidentCoordinatorDelegate? = nil) {
        self.delegate = delegate
    }
    
    override func start() {
        let viewController: AccFlw1Stp1VController = storyboard.instantiateViewController()
        viewController.viewModel = AccFlw1Stp1ViewModel()
        viewController.viewModel.coordinatorDelegate = self
        navigationController.navigationBar.isHidden = true
        navigationController.setViewControllers([viewController], animated: true)
    }
    
    override func finish() {
        delegate?.didFinish(from: self)
    }
}

// MARK: FLOW 1
extension AccidentCoordinator: AccFlw1Stp1VMCrdinatorDlgt,
                               AccFlw1Stp2OtherVehicleVMCrdinatorDlgt {
    func getBack() {
        navigationController.popViewController(animated: true)
    }
    
    func getBackToHome() {
        self.navigationController.select(tab: 2)
        navigationController.popToRootViewController(animated: true)
    }
    
    func goToAccFlw1Stp2OtherVehicle() {
        let viewController: AccFlw1Stp2OtherVehicleViewController = storyboard.instantiateViewController()
        viewController.viewModel = AccFlw1Stp2OtherVehicleViewModel()
        viewController.viewModel.coordinatorDelegate = self
        navigationController.pushViewController(viewController, animated: true)
    }
}
