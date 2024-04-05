//
//  PastServicesCoordinator.swift
//  Copilot
//
//  Created by Jamal on 3/28/24.
//

import Foundation
import UIKit

protocol PastServicesCoordinatorDelegate: AnyObject {
    func didFinish(from coordinator: Coordinator)
}

class PastServicesCoordinator: Coordinator {
    
    let navigationController: UINavigationController
    let storyboard = UIStoryboard(storyboard: .pastServices)
    weak var delegate: PastServicesCoordinatorDelegate?
    
    weak var filterViewController: UIViewController?
    
    init(navigationController: UINavigationController, delegate: PastServicesCoordinatorDelegate? = nil) {
        self.navigationController = navigationController
        self.delegate = delegate
    }
    
    override func start() {
        let page: PageViewController = PageViewController()
        let controller: PastMaintenancesViewController = storyboard.instantiateViewController()
        controller.viewModel = PastMaintenancesViewModel()
        page.setViewControllers([controller], direction: .forward, animated: true)
        controller.viewModel.coordinatorDelegate = self
        navigationController.pushViewController(page, animated: true)
    }
    
    override func finish() {
        delegate?.didFinish(from: self)
    }
}

extension PastServicesCoordinator: PastMaintenancesVMCrdinatorDelegate,
                                   PastServicesFilterVMCoordinatorDelegate,
                                   PastServicesSortVMCoordinatorDelegate,
                                   PastServiceDetailVMCoordinatorDelegate {
    func getBack() {
        navigationController.popViewController(animated: true)
    }
    
    func presentFilters(services: [PastService], delegate: PastServicesFilterViewControllerDelegate) {
        let controller: PastServicesFilterViewController = storyboard.instantiateViewController()
        let viewModel = PastServicesFilterViewModel()
        controller.viewModel = viewModel
        viewModel.services = services
        controller.delegate = delegate
        viewModel.coordinatorDelegate = self
        filterViewController = controller
        navigationController.present(controller, animated: true)
    }
    
    func presentCalendar(delegate: CalendarViewControllerDelegate) {
        let controller: CalendarViewController = UIStoryboard(storyboard: .services).instantiateViewController()
        let viewModel = CalendarViewModel()
        controller.viewModel = viewModel
        controller.delegate = delegate
        viewModel.shouldSelectSpecificDays = false
        filterViewController?.present(controller, animated: true)
    }
    
    func presentSort(delegate: PastServicesSortViewControllerDelegate) {
        let controller: PastServicesSortViewController = storyboard.instantiateViewController()
        let viewModel = PastServicesSortViewModel()
        controller.viewModel = viewModel
        controller.delegate = delegate
        viewModel.coordinatorDelegate = self
        navigationController.present(controller, animated: true)
    }
    
    func goToPastServiceDetail(service: PastService, title: String) {
        let controller: PastServiceDetailViewController = storyboard.instantiateViewController()
        let viewModel = PastServiceDetailViewModel()
        controller.viewModel = viewModel
        viewModel.coordinatorDelegate = self
        viewModel.title = title
        viewModel.service = service
        navigationController.pushViewController(controller, animated: true)
    }
}
