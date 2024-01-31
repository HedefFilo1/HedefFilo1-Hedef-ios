//
//  ServicesCoordinator.swift
//  Copilot
//
//  Created by Jamal on 12/19/23.
//

import Foundation
import UIKit

protocol ServicesCoordinatorDelegate: AnyObject {
    func didFinish(from coordinator: Coordinator)
}

class ServicesCoordinator: Coordinator {
    
    lazy var navigationController: UINavigationController = {
        let navVC = UINavigationController()
        return navVC
    }()
    
    let storyboard = UIStoryboard(storyboard: .services)
    weak var delegate: ServicesCoordinatorDelegate?
    
    override func start() {
        let viewController: ServiceTabViewController = storyboard.instantiateViewController()
        viewController.viewModel = ServiceTabViewModel()
        viewController.viewModel.coordinatorDelegate = self
        navigationController.navigationBar.isHidden = true
        navigationController.setViewControllers([viewController], animated: true)
    }
    
    override func finish() {
        delegate?.didFinish(from: self)
    }
}

extension ServicesCoordinator: ServiceTabViewModelCoordinatorDelegate {
    
    func goToLastikOperations(appointment: Case?) {
        let coordinator = TireCoordinator(navigationController: navigationController, delegate: self)
        addChildCoordinator(coordinator)
        coordinator.start(appointment: appointment)
    }
    
    func goToMiantenance(appointment: Case?) {
        let coordinator = MaintenanceCoordinator(navigationController: navigationController, delegate: self)
        addChildCoordinator(coordinator)
        coordinator.start(appointment: appointment)
    }
    
    func goToBreakDown() {
        let coordinator = BreakDownCoordinator(navigationController: navigationController, delegate: self)
        addChildCoordinator(coordinator)
        coordinator.start()
    }
}

extension ServicesCoordinator {
    
    func goToRequestNewLastik() {
        
    }
    
    func goToLastikRandevu() {
        let viewController: LastikRandevuViewController = storyboard.instantiateViewController()
        viewController.viewModel = LastikRandevuViewModel()
        viewController.viewModel.coordinatorDelegate = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func goToLastikChange() {
        //        let viewController: Flow5Step2TireChangeViewController = storyboard.instantiateViewController()
        //        viewController.viewModel = LastikChangeViewModel()
        //        viewController.viewModel.coordinatorDelegate = self
        //        navigationController.pushViewController(viewController, animated: true)
    }
    
    func getBack() {
        navigationController.popViewController(animated: true)
    }
}

extension ServicesCoordinator {
    func goToLastikFromManger() {
        
    }
}

extension ServicesCoordinator {
    func goToRequestLastikResult() {
        
    }
}

extension ServicesCoordinator {
    func getBackToHome() {
        navigationController.popToRootViewController(animated: true)
    }
    
    func goToRequests() {
        
    }
}

extension ServicesCoordinator: LastikRandevuVMCoordinatorDelegate {
    
    func goToLastikRandevuConfirmation() {
        
    }
}

extension ServicesCoordinator {
    
    func goToLastikConfirmInfo() {
        //        let viewController: LastikConfirmInfoViewController = storyboard.instantiateViewController()
        //        viewController.viewModel = LastikConfirmInfoViewModel()
        //        viewController.viewModel.coordinatorDelegate = self
        //        navigationController.pushViewController(viewController, animated: true)
    }
}

extension ServicesCoordinator {
    func goToServices(tireSupportType: TireSupportType) {
        //        let viewController: ServicesViewController = storyboard.instantiateViewController()
        //        viewController.viewModel = ServicesViewModel()
        //        viewController.viewModel.coordinatorDelegate = self
        //        viewController.viewModel.tireSupportType = tireSupportType
        //        navigationController.pushViewController(viewController, animated: true)
    }
}

// neeed to remove this block
extension ServicesCoordinator: ServicesVMCoordinatorDelegate {
    
    func presentFilters(services: [Supplier], delegate: ServiceFilterViewControllerDelegate) {
        //        let controller: ServiceFilterViewController = UIStoryboard(storyboard: .vehicle).instantiateViewController()
        //        let viewModel = ServiceFilterViewModel()
        //        controller.viewModel = viewModel
        //        viewModel.services = services
        //        controller.delegate = delegate
        //        navigationController.present(controller, animated: true)
    }
    
    func goToServiceDetail(service: Supplier?, appointment: Case?, tireSupportType: TireSupportType?) {
        //        let controller: ServiceDetailViewController = storyboard.instantiateViewController()
        //        let viewModel = ServiceDetailViewModel()
        //        controller.viewModel = viewModel
        //        viewModel.coordinatorDelegate = self
        //        viewModel.appointment = appointment
        //        viewModel.service = service
        //        viewModel.tireSupportType = tireSupportType
        //        navigationController.pushViewController(controller, animated: true)
    }
}

extension ServicesCoordinator: ServiceDetailVMCoordinatorDelegate {
    
    func goToServiceRandevu(service: Supplier, date: Date, tireSupportType: TireSupportType) {
        //        let controller: ServiceRandevuViewController = storyboard.instantiateViewController()
        //        let viewModel = ServiceRandevuViewModel()
        //        viewModel.service = service
        //        viewModel.date = date
        //        controller.viewModel = viewModel
        //        viewModel.coordinatorDelegate = self
        //        viewModel.tireSupportType = tireSupportType
        //        navigationController.pushViewController(controller, animated: true)
    }
    
    func presentCalendar(delegate: CalendarViewControllerDelegate) {
        //        let controller: CalendarViewController = storyboard.instantiateViewController()
        //        let viewModel = CalendarViewModel()
        //        controller.viewModel = viewModel
        //        controller.delegate = delegate
        //        navigationController.present(controller, animated: true)
    }
}

extension ServicesCoordinator: ServiceRandevuVMCoordinatorDelegate {
    func goToConfirmedRandevu(service: Supplier, date: Date) {
        //        let controller: ConfirmedRandevuViewController = storyboard.instantiateViewController()
        //        let viewModel = ConfirmedRandevuViewModel()
        //        viewModel.service = service
        //        viewModel.date = date
        //        controller.viewModel = viewModel
        //        viewModel.coordinatorDelegate = self
        //        navigationController.pushViewController(controller, animated: true)
    }
}

extension ServicesCoordinator {
    
}

extension ServicesCoordinator: ConfirmedRandevuVMCoordinatorDelegate {
    
}

extension ServicesCoordinator: TireCoordinatorDelegate,
                               MaintenanceCoordinatorDelegate,
                               BreakDownCoordinatorDelegate {
    
    func didFinish(from coordinator: Coordinator) {
        removeChildCoordinator(coordinator)
    }
}
