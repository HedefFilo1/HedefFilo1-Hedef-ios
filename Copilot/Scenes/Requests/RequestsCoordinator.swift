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
    weak var delegate: RequestsCoordinatorDelegate?
    var requstListPage: RequestListPageController?
    
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
                               ReqFlw3Stp3HGSVMCoordinatorDelegate,
                               ReqFlw4Stp3PlateVMCoordinatorDelegate,
                               ReqFlw5Stp3LicenseVMCoordinatorDelegate,
                               ReqFlw6Stp3InspectionVMCrdntrDelegate,
                               RequestListTasksVMCrdntrDelegate,
                               RequestDetailVMCrdntrDelegate,
                               CanceledRequestVMCoordinatorDelegate,
                               RequestListRequestsVMCrdntrDelegate {
    func goToSuccess() {
        
    }

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
    
    func goToSuccess(title: String, message: String, description: String) {
        let controller: RequestSuccessViewController = storyboard.instantiateViewController()
        controller.viewModel = RequestSuccessViewModel()
        controller.viewModel.coordinatorDelegate = self
        controller.viewModel.title = title
        controller.viewModel.message = message
        controller.viewModel.description = description
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
    
    func goToReqFlw4Stp3Plate() {
        let controller: ReqFlw4Stp3PlateViewController = storyboard.instantiateViewController()
        controller.viewModel = ReqFlw4Stp3PlateViewModel()
        controller.viewModel.coordinatorDelegate = self
        navigationController.pushViewController(controller, animated: true)
    }
    
    func goToReqFlw5Stp3License() {
        let controller: ReqFlw5Stp3LicenseViewController = storyboard.instantiateViewController()
        controller.viewModel = ReqFlw5Stp3LicenseViewModel()
        controller.viewModel.coordinatorDelegate = self
        navigationController.pushViewController(controller, animated: true)
    }
    
    func goToReqFlw6Stp3Inspection() {
        let controller: ReqFlw6Stp3InspectionViewController = storyboard.instantiateViewController()
        controller.viewModel = ReqFlw6Stp3InspectionViewModel()
        controller.viewModel.coordinatorDelegate = self
        navigationController.pushViewController(controller, animated: true)
    }
    
    func goToRequestList() {
        let page1: RequestListTasksViewController = storyboard.instantiateViewController()
        page1.viewModel = RequestListTasksViewModel()
        page1.viewModel.coordinatorDelegate = self
        
        let page2: RequestListRequestsViewController = storyboard.instantiateViewController()
        page2.viewModel = RequestListRequestsViewModel()
        page2.viewModel.coordinatorDelegate = self
        
        let pages = RequestListPageController()
        requstListPage = pages
        requstListPage?.pages = [page1, page2]
        navigationController.pushViewController(pages, animated: true)
    }
    
    func showRequestsList() {
        requstListPage?.showPage2()
    }
    
    func showTasksList() {
        requstListPage?.showPage1()
    }
    
    func presentFitlers(title: String,
                        delegate: RequestListFilterViewControllerDelegate,
                        items: [RequestListFilterItem]) {
        let controller: RequestListFilterViewController = storyboard.instantiateViewController()
        let viewModel = RequestListFilterViewModel()
        controller.viewModel = viewModel
        viewModel.items = items
        controller.delegate = delegate
        viewModel.title = title
        navigationController.present(controller, animated: true)
    }
    
    func goToRequestDetail(item: Task) {
        let controller: RequestDetailViewController = storyboard.instantiateViewController()
        controller.viewModel = RequestDetailViewModel()
        controller.viewModel.coordinatorDelegate = self
        controller.viewModel.item = item
        navigationController.pushViewController(controller, animated: true)
    }
    
    func goToCanceledRequest(title: String) {
        let controller: CanceledRequestViewController = storyboard.instantiateViewController()
        controller.viewModel = CanceledRequestViewModel()
        controller.viewModel.coordinatorDelegate = self
        controller.viewModel.title = title
        navigationController.pushViewController(controller, animated: true)
    }
}
