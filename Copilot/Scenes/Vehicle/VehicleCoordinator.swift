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
        //        let viewController: VehicleGuideViewController = storyboard.instantiateViewController()
        //        viewController.viewModel = VehicleGuideViewModel()
        //        viewController.viewModel.coordinatorDelegate = self
        //        navigationController.pushViewController(viewController, animated: true)
        let viewController: PdfViewerViewController = storyboard.instantiateViewController()
        viewController.viewModel = PdfViewerViewModel()
        viewController.viewModel.coordinatorDelegate = self
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension VehicleCoordinator: HGSViewModelCoordinatorDelegate {
    func goToHGSDetail(transition: Transition) {
        let viewController: HGSDetailViewController = storyboard.instantiateViewController()
        viewController.viewModel = HGSDetailViewModel()
        viewController.viewModel.coordinatorDelegate = self
        viewController.viewModel.transition = transition
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension VehicleCoordinator: DocumentViewModelCoordinatorDelegate,
                              VehicleGuideViewModelCoordinatorDelegate,
                              HGSDetailViewModelCoordinatorDelegate,
                              PdfViewerViewModelCoordinatorDelegate {
    func getBack() {
        navigationController.popViewController(animated: true)
    }
}
