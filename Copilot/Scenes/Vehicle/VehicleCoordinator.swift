//
//  VehicleCoordinator.swift
//  Copilot
//
//  Created by Jamal on 11/23/23.
//

import Foundation
import UIKit

protocol VehicleCoordinatorDelegate: AnyObject {
    func didFinish(from coordinator: Coordinator)
}

class VehicleCoordinator: Coordinator {
    
    let navigationController: UINavigationController
    let storyboard = UIStoryboard(storyboard: .vehicle)
    weak var delegate: VehicleCoordinatorDelegate?
    
    init(with navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() {
        
    }
    
    override func finish() {
        delegate?.didFinish(from: self)
    }
}

extension VehicleCoordinator: VehicleInfoViewModelCoordinatorDelegate {
    func goToDocument() {
        let viewController: DocumentViewController = UIStoryboard(storyboard: .main).instantiateViewController()
        viewController.viewModel = DocumentViewModel()
        viewController.viewModel.coordinatorDelegate = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func goToVehicleGuide() {
        let viewController: VehicleGuideViewController = storyboard.instantiateViewController()
        viewController.viewModel = VehicleGuideViewModel()
        viewController.viewModel.coordinatorDelegate = self
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension VehicleCoordinator: DocumentViewModelCoordinatorDelegate, VehicleGuideViewModelCoordinatorDelegate {
    func getBack() {
        navigationController.popViewController(animated: true)
    }
}
