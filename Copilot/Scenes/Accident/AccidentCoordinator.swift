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
                               AccFlw1Stp2OtherVehicleVMCrdinatorDlgt,
                               AccFlw1Stp3AgreementVMCrdinatorDlgt,
                               AccFlw1Stp4ReportVMCrdinatorDlgt,
                               AccFlw1Stp5LeaksVMCrdinatorDlgt,
                               AccFlw1Stp6ConfirmVMCrdinatorDlgt,
                               AccFlw1Stp7SelectServiceVMCrdinatorDlgt {
    
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
    
    func goToAccFlw1Stp3Agreement() {
        let viewController: AccFlw1Stp3AgreementViewController = storyboard.instantiateViewController()
        viewController.viewModel = AccFlw1Stp3AgreementViewModel()
        viewController.viewModel.coordinatorDelegate = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func goToAccFlw1Stp4Report() {
        let viewController: AccFlw1Stp4ReportViewController = storyboard.instantiateViewController()
        viewController.viewModel = AccFlw1Stp4ReportViewModel()
        viewController.viewModel.coordinatorDelegate = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func goToAccFlw1Stp3Leaks() {
        let viewController: AccFlw1Stp5LeaksViewController = storyboard.instantiateViewController()
        viewController.viewModel = AccFlw1Stp5LeaksViewModel()
        viewController.viewModel.coordinatorDelegate = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func goToAccFlw1Stp6Confirm() {
        let viewController: AccFlw1Stp6ConfirmViewController = storyboard.instantiateViewController()
        viewController.viewModel = AccFlw1Stp6ConfirmViewModel()
        viewController.viewModel.coordinatorDelegate = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func goToAccFlw1Stp7SelectService() {
        let viewController: AccFlw1Stp7SelectServiceViewController = storyboard.instantiateViewController()
        viewController.viewModel = AccFlw1Stp7SelectServiceViewModel()
        viewController.viewModel.coordinatorDelegate = self
        navigationController.pushViewController(viewController, animated: true)
    }
}

// MARK: Services
extension AccidentCoordinator: AccidentServicesCrdinatorDlgt,
                               ServicesVMCoordinatorDelegate,
                               AccidentServiceDetailVMCrdintrDlgt,
                               AccidentSuccessRandevuVMCrdinatorDlgt {
    
    func goToServices(towTruck: Bool) {
        let viewController: AccidentServicesViewController = storyboard.instantiateViewController()
        let viewModel = AccidentServicesViewModel()
        viewModel.accidentCoordinatorDelegate = self
        viewModel.coordinatorDelegate = self
        viewModel.towTruck = towTruck
        viewController.viewModel = viewModel
        viewController.viewModel.supplierType = .damage
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func goToServiceDetail(towTruck: Bool, service: Supplier) {
        let controller: AccidentServiceDetailVController = storyboard.instantiateViewController()
        controller.viewModel = AccidentServiceDetailViewModel()
        controller.viewModel.coordinatorDelegate = self
        controller.viewModel.service = service
        controller.viewModel.towTruck = towTruck
        navigationController.pushViewController(controller, animated: true)
    }
    
    func goToServiceDetail(service: Supplier?, appointment: Case?, tireSupportType: TireSupportType?, towTruck: Bool) {
        
    }
    
    func presentCalendar(delegate: CalendarViewControllerDelegate) {
        let controller: CalendarViewController = UIStoryboard(storyboard: .services).instantiateViewController()
        let viewModel = CalendarViewModel()
        controller.viewModel = viewModel
        controller.delegate = delegate
        navigationController.present(controller, animated: true)
    }
    
    func presentFilters(services: [Supplier], delegate: ServiceFilterViewControllerDelegate) {
        let controller: ServiceFilterViewController = UIStoryboard(storyboard: .vehicle).instantiateViewController()
        let viewModel = ServiceFilterViewModel()
        controller.viewModel = viewModel
        viewModel.services = services
        controller.delegate = delegate
        navigationController.present(controller, animated: true)
    }
    
    func goToAccidentSuccessRandevu(service: Supplier, date: Date?) {
        let controller: AccidentSuccessRandevuViewController = storyboard.instantiateViewController()
        controller.viewModel = AccidentSuccessRandevuViewModel()
        controller.viewModel.coordinatorDelegate = self
        controller.viewModel.service = service
        controller.viewModel.date = date
        navigationController.pushViewController(controller, animated: true)
    }
}
