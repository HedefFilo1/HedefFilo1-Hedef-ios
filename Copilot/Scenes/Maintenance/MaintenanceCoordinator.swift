//
//  MaintenanceCoordinator.swift
//  Copilot
//
//  Created by Jamal on 1/30/24.
//

import Foundation
import UIKit

protocol MaintenanceCoordinatorDelegate: AnyObject {
    func didFinish(from coordinator: Coordinator)
}

class MaintenanceCoordinator: Coordinator {
    
    let navigationController: UINavigationController
    let storyboard = UIStoryboard(storyboard: .maintenance)
    weak var delegate: MaintenanceCoordinatorDelegate?
    
    init(navigationController: UINavigationController, delegate: MaintenanceCoordinatorDelegate? = nil) {
        self.navigationController = navigationController
        self.delegate = delegate
    }
    
    func start(appointment: Case?) {
        let viewController: MaintenanceViewController = storyboard.instantiateViewController()
        viewController.viewModel = MaintenanceViewModel()
        viewController.viewModel.coordinatorDelegate = self
        viewController.viewModel.appointment = appointment
        navigationController.pushViewController(viewController, animated: true)
    }
    
    override func finish() {
        delegate?.didFinish(from: self)
    }
}

extension MaintenanceCoordinator: MaintenanceVMCoordinatorDelegate {
 
    func getBack() {
        navigationController.popViewController(animated: true)
    }
    
    func getBackToHome() {
        self.navigationController.select(tab: 2)
        navigationController.popToRootViewController(animated: true)
    }
    
    func goToMaintenanceStep2KM() {
        let controller: MaintenanceStep2KMViewController = storyboard.instantiateViewController()
        controller.viewModel = MaintenanceStep2KMViewModel()
        controller.viewModel.coordinatorDelegate = self
        navigationController.pushViewController(controller, animated: true)
    }
}

extension MaintenanceCoordinator: MaintenanceStep2KMVMCoordinatorDelegate,
                                  NotMaintenancePeriodVMCoordinatorDlgt {
    
    func goToNotMaintenancePeriod(nextMaintenanceKm: Int, userInputKm: Int) {
        let controller: NotMaintenancePeriodViewController = storyboard.instantiateViewController()
        controller.viewModel = NotMaintenancePeriodViewModel()
        controller.viewModel.coordinatorDelegate = self
        controller.viewModel.nextMaintenanceKm = nextMaintenanceKm
        controller.viewModel.userInputKm = userInputKm
        navigationController.pushViewController(controller, animated: true)
    }
    
}

// services
extension MaintenanceCoordinator: ServicesVMCoordinatorDelegate,
                                  ServiceDetailVMCoordinatorDelegate {
    
    func goToServices() {
        let viewController: MaintenanceServicesViewController = storyboard.instantiateViewController()
        viewController.viewModel = ServicesViewModel()
        viewController.viewModel.coordinatorDelegate = self
        viewController.viewModel.towTruck = false
        viewController.viewModel.supplierType = .maintenance
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func presentFilters(services: [Supplier], delegate: ServiceFilterViewControllerDelegate) {
        let controller: ServiceFilterViewController = UIStoryboard(storyboard: .vehicle).instantiateViewController()
        let viewModel = ServiceFilterViewModel()
        controller.viewModel = viewModel
        viewModel.services = services
        controller.delegate = delegate
        navigationController.present(controller, animated: true)
    }
    
    func goToServiceDetail(service: Supplier?, appointment: Case?, tireSupportType: TireSupportType?, towTruck: Bool) {
        let controller: MaintenanceServiceDetailViewController = storyboard.instantiateViewController()
        let viewModel = MaintenanceServiceDetailViewModel()
        controller.viewModel = viewModel
        viewModel.coordinatorDelegate = self
        viewModel.appointment = appointment
        viewModel.service = service
        viewModel.tireSupportType = tireSupportType
        viewModel.towTruck = towTruck
        navigationController.pushViewController(controller, animated: true)
    }
    
    func presentCalendar(delegate: CalendarViewControllerDelegate) {
        let controller: CalendarViewController = UIStoryboard(storyboard: .services).instantiateViewController()
        let viewModel = CalendarViewModel()
        controller.viewModel = viewModel
        controller.delegate = delegate
        navigationController.present(controller, animated: true)
    }
}

extension MaintenanceCoordinator: ServiceRandevuVMCoordinatorDelegate,
                                  ConfirmedRandevuVMCoordinatorDelegate {
    
    func goToServiceRandevu(service: Supplier?, date: Date?, tireSupportType: TireSupportType?, towTruck: Bool, appointment: Case?) {
        let controller: MaintenanceRandevuViewController = storyboard.instantiateViewController()
        let viewModel = MaintenanceRandevuViewModel()
        viewModel.service = service
        viewModel.date = date
        viewModel.appointment = appointment
        controller.viewModel = viewModel
        viewModel.coordinatorDelegate = self
        viewModel.tireSupportType = tireSupportType
        viewModel.towTruck = false
        navigationController.pushViewController(controller, animated: true)
    }
    
    func goToConfirmedRandevu(service: Supplier?, date: Date?, appointment: Case?) {
        let controller: MaintenanceConfirmViewController = storyboard.instantiateViewController()
        let viewModel = ConfirmedRandevuViewModel()
        viewModel.service = service
        viewModel.date = date
        viewModel.appointment = appointment
        controller.viewModel = viewModel
        viewModel.coordinatorDelegate = self
        navigationController.pushViewController(controller, animated: true)
    }
}
