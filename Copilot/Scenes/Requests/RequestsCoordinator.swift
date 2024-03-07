//
//  RequestsCoordinator.swift
//  Copilot
//
//  Created by Jamal on 3/4/24.
//

import Foundation
import UIKit

protocol RequestsCoordinatorDelegate: AnyObject {
    func didFinish(from coordinator: Coordinator)
}

class RequestsCoordinator: Coordinator {
    
    let navigationController: UINavigationController
    let storyboard = UIStoryboard(storyboard: .requests)
    weak var delegate: VehicleCoordinatorDelegate?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() {
        let viewController: RequestsViewController = storyboard.instantiateViewController()
        viewController.viewModel = RequestsViewModel()
        viewController.viewModel.coordinatorDelegate = self
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension RequestsCoordinator: RequestsViewModelCoordinatorDelegate,
                               ReqFlw1Stp2ViewModelCoordinatorDelegate,
                               RequestSuccessVMCoordinatorDelegate,
                               ReqFlw2Stp2QuestionsVMCrdintrDelegate,
                               ReqFlw2Stp3VehicleVMCoordinatorDelegate,
                               ReqFlw3Stp3HGSVMCoordinatorDelegate {
    func getBackToHome() {
        self.navigationController.select(tab: 2)
        navigationController.popToRootViewController(animated: true)
    }
    
    func goToRequests() {
        
        for item in navigationController.viewControllers where item.isKind(of: RequestsViewController.self) {
            navigationController.popToViewController(item, animated: true)
            return
        }
        navigationController.popToRootViewController(animated: true)
    }
    
    func getBack() {
        navigationController.popViewController(animated: true)
    }
    
    func goToReqFlw1Stp2() {
        let controller: ReqFlw1Stp2ViewController = storyboard.instantiateViewController()
        controller.viewModel = ReqFlw1Stp2ViewModel()
        controller.viewModel.coordinatorDelegate = self
        navigationController.pushViewController(controller, animated: true)
    }
    
    func goToSuccess() {
        let controller: RequestSuccessViewController = storyboard.instantiateViewController()
        controller.viewModel = RequestSuccessViewModel()
        controller.viewModel.coordinatorDelegate = self
        navigationController.pushViewController(controller, animated: true)
    }
    
    func goToReqFlw2Stp2Questions() {
        let controller: ReqFlw2Stp2QuestionsViewController = storyboard.instantiateViewController()
        controller.viewModel = ReqFlw2Stp2QuestionsViewModel()
        controller.viewModel.coordinatorDelegate = self
        navigationController.pushViewController(controller, animated: true)
    }
    
    func goToReqFlw2Stp3Vehicle() {
        let controller: ReqFlw2Stp3VehicleViewController = storyboard.instantiateViewController()
        controller.viewModel = ReqFlw2Stp3VehicleViewModel()
        controller.viewModel.coordinatorDelegate = self
        navigationController.pushViewController(controller, animated: true)
    }
    
    func goToReqFlw3Stp3HGS() {
        let controller: ReqFlw3Stp3HGSViewController = storyboard.instantiateViewController()
        controller.viewModel = ReqFlw3Stp3HGSViewModel()
        controller.viewModel.coordinatorDelegate = self
        navigationController.pushViewController(controller, animated: true)
    }
}
