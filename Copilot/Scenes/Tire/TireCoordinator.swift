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

// Flow 1, 2
extension TireCoordinator: TireOperationsVMCoordinatorDelegate,
                           Flow1Step2NewTireVMCoordinatorDelegate,
                           Flow1Step3TireTypesVMCoordinatorDelegate,
                           Flow1Step4ResultVMCoordinatorDelegate {
    
    func getBackToHome() {
        self.navigationController.select(tab: 2)
        navigationController.popToRootViewController(animated: true)
    }
    
    func goToRequests() {
        
    }
    
    func goToPastServices(tab: PastServiceRecordType) {
        let coordinator = PastServicesCoordinator(navigationController: navigationController, delegate: self)
        addChildCoordinator(coordinator)
        coordinator.start(tab: tab)
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
    
    func goToFlow1Step4Result(tireType: TireControlType) {
        let viewController: Flow1Step4ResultViewController = storyboard.instantiateViewController()
        viewController.viewModel = Flow1Step4ResultViewModel()
        viewController.viewModel.coordinatorDelegate = self
        viewController.viewModel.tireType = tireType
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func goToFlow2Step2TireTypes() {
        let viewController: Flow1Step3TireTypesViewController = storyboard.instantiateViewController()
        viewController.viewModel = Flow1Step3TireTypesViewModel()
        viewController.viewModel.coordinatorDelegate = self
        navigationController.pushViewController(viewController, animated: true)
    }
}

// FLOW 3, 4
extension TireCoordinator: Flow3Step2DamageVMCrdintrDelegate,
                           Flow3Step3ConfirmVMCrdintrDelegate,
                           Flow3Step4TowTruckVMCoordinatorDelegate,
                           Flow4Step3SelectServiceVMCoordinatorDlgt {
    
    func goToFlow3Step2Damage() {
        let viewController: Flow3Step2DamageViewController = storyboard.instantiateViewController()
        viewController.viewModel = Flow3Step2DamageViewModel()
        viewController.viewModel.coordinatorDelegate = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func goToFlow3Step3Confirm() {
        let viewController: Flow3Step3ConfirmViewController = storyboard.instantiateViewController()
        viewController.viewModel = Flow3Step3ConfirmViewModel()
        viewController.viewModel.coordinatorDelegate = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func goToFlow3Step4TowTruck() {
        let viewController: Flow3Step4TowTruckViewController = storyboard.instantiateViewController()
        viewController.viewModel = Flow3Step4TowTruckViewModel()
        viewController.viewModel.coordinatorDelegate = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func goToFlow4Step3SelectService() {
        let viewController: Flow4Step3SelectServiceViewController = storyboard.instantiateViewController()
        viewController.viewModel = Flow4Step3SelectServiceViewModel()
        viewController.viewModel.coordinatorDelegate = self
        viewController.viewModel.tireSupportType = .damage
        navigationController.pushViewController(viewController, animated: true)
    }
}

// FLOW 5, 6
extension TireCoordinator: Flow5Step2TireChangeVMCoordinatorDlgt {

    func goToFlow5Step2TireChange(tireService: Supplier?) {
        let viewController: Flow5Step2TireChangeViewController = storyboard.instantiateViewController()
        viewController.viewModel = Flow5Step2TireChangeViewModel()
        viewController.viewModel.coordinatorDelegate = self
        viewController.viewModel.tireService = tireService
        navigationController.pushViewController(viewController, animated: true)
    }
}

// Flow 7
extension TireCoordinator {
    func goToFlow7Step2SelectService() {
        let viewController: Flow4Step3SelectServiceViewController = storyboard.instantiateViewController()
        viewController.viewModel = Flow4Step3SelectServiceViewModel()
        viewController.viewModel.coordinatorDelegate = self
        viewController.viewModel.tireSupportType = .change
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension TireCoordinator: ServicesVMCoordinatorDelegate {
    
    func goToServices(tireSupportType: TireSupportType, towTruck: Bool) {
        let viewController: ServicesViewController = UIStoryboard(storyboard: .services).instantiateViewController()
        viewController.viewModel = ServicesViewModel()
        viewController.viewModel.coordinatorDelegate = self
        viewController.viewModel.tireSupportType = tireSupportType
        viewController.viewModel.towTruck = towTruck
//        viewController.viewModel.supplierType = tireSupportType == .change ? .tire: .damage
        viewController.viewModel.supplierType = .tire
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
        let controller: ServiceDetailViewController = UIStoryboard(storyboard: .services).instantiateViewController()
        let viewModel = ServiceDetailViewModel()
        controller.viewModel = viewModel
        viewModel.coordinatorDelegate = self
        viewModel.appointment = appointment
        viewModel.service = service
        viewModel.tireSupportType = tireSupportType
        viewModel.towTruck = towTruck
        navigationController.pushViewController(controller, animated: true)
    }
}

extension TireCoordinator: ServiceDetailVMCoordinatorDelegate {
   
    func goToServiceRandevu(service: Supplier?, date: Date?, tireSupportType: TireSupportType?, towTruck: Bool, appointment: Case?) {
        let controller: ServiceRandevuViewController = UIStoryboard(storyboard: .services).instantiateViewController()
        let viewModel = ServiceRandevuViewModel()
        viewModel.service = service
        viewModel.date = date
        viewModel.appointment = appointment
        controller.viewModel = viewModel
        viewModel.coordinatorDelegate = self
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

extension TireCoordinator: ServiceRandevuVMCoordinatorDelegate,
                           ConfirmedRandevuVMCoordinatorDelegate {
    func goToConfirmedRandevu(service: Supplier?, date: Date?, appointment: Case?, tireSupportType: TireSupportType?) {
        let controller: ConfirmedRandevuViewController = UIStoryboard(storyboard: .services).instantiateViewController()
        let viewModel = ConfirmedRandevuViewModel()
        viewModel.service = service
        viewModel.date = date
        viewModel.appointment = appointment
        controller.viewModel = viewModel
        viewModel.tireSupportType = tireSupportType
        viewModel.coordinatorDelegate = self
        navigationController.pushViewController(controller, animated: true)
    }
}

extension TireCoordinator: PastServicesCoordinatorDelegate {
    func didFinish(from coordinator: Coordinator) {
        removeChildCoordinator(coordinator)
    }
}
