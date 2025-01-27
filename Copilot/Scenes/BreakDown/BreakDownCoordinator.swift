//
//  BreakDownCoordinator.swift
//  Copilot
//
//  Created by Jamal on 1/31/24.
//

import Foundation
import UIKit
import PDFKit

protocol BreakDownCoordinatorDelegate: AnyObject {
    func didFinish(from coordinator: Coordinator)
}

class BreakDownCoordinator: Coordinator {
    
    let navigationController: UINavigationController
    let storyboard = UIStoryboard(storyboard: .breakDown)
    weak var delegate: BreakDownCoordinatorDelegate?
    
    init(navigationController: UINavigationController, delegate: BreakDownCoordinatorDelegate? = nil) {
        self.navigationController = navigationController
        self.delegate = delegate
    }
    
    func start(appointment: Case?) {
        let viewController: BreakDownViewController = storyboard.instantiateViewController()
        viewController.viewModel = BreakDownViewModel()
        viewController.viewModel.coordinatorDelegate = self
        viewController.viewModel.appointment = appointment
        navigationController.pushViewController(viewController, animated: true)
    }
    
    override func finish() {
        delegate?.didFinish(from: self)
    }
}

extension BreakDownCoordinator: BreakDownVMCoordinatorDelegate,
                                BreakDownSuccessRandevuVMCrdinatorDlgt {
    
    func getBack() {
        navigationController.popViewController(animated: true)
    }
    
    func getBackToHome() {
        self.navigationController.select(tab: 2)
        navigationController.popToRootViewController(animated: true)
    }
    
    func goToBreakDownSuccessRandevu(service: Supplier?, appointment: Case?, date: Date?) {
        let controller: BreakDownSuccessRandevuViewController = storyboard.instantiateViewController()
        controller.viewModel = BreakDownSuccessRandevuViewModel()
        controller.viewModel.coordinatorDelegate = self
        controller.viewModel.service = service
        controller.viewModel.date = date
        controller.viewModel.appointment = appointment
        navigationController.pushViewController(controller, animated: true)
    }
    func goToFlow1BreakDownStep2TowTruck() {
        let controller: BrkdwnFlw1Stp2TowTruckVController = storyboard.instantiateViewController()
        controller.viewModel = BrkdwnFlw1Stp2TowTruckViewModel()
        controller.viewModel.coordinatorDelegate = self
        navigationController.pushViewController(controller, animated: true)
    }
}

// MARK: FLOW 1
extension BreakDownCoordinator: BrkdwnFlw1Stp2TowTruckVMCrdinatorDlgt,
                                BrkdwnFlw1Stp3SelectServiceVMCrdintrDlgt,
                                BrkdwnFlw1Stp2ServicesCrdinatorDlgt,
                                BrkdwnFlw1Stp5ServiceDetailVMCrdintrDlgt {
    
    func goToBrkdwnFlw1Stp3SelectService() {
        let controller: BrkdwnFlw1Stp3SelectServiceVController = storyboard.instantiateViewController()
        controller.viewModel = BrkdwnFlw1Stp3SelectServiceViewModel()
        controller.viewModel.coordinatorDelegate = self
        navigationController.pushViewController(controller, animated: true)
    }
    
    func goToServices(towTruck: Bool) {
        let viewController: BrkdwnFlw1Stp4ServicesVController = storyboard.instantiateViewController()
        let viewModel = BrkdwnFlw1Stp2ServicesViewModel()
        viewModel.breakDownCoordinatorDelegate = self
        viewModel.coordinatorDelegate = self
        viewModel.towTruck = towTruck
        viewController.viewModel = viewModel
        viewController.viewModel.supplierType = .maintenance
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func goToBrkdwnFlw1Stp5ServiceDetail(towTruck: Bool, service: Supplier?, appointment: Case?) {
        let controller: BrkdwnFlw1Stp5ServiceDetailVController = storyboard.instantiateViewController()
        controller.viewModel = BrkdwnFlw1Stp5ServiceDetailViewModel()
        controller.viewModel.coordinatorDelegate = self
        controller.viewModel.service = service
        controller.viewModel.towTruck = towTruck
        controller.viewModel.appointment = appointment
        navigationController.pushViewController(controller, animated: true)
    }
    
    func goToServiceDetail(appointment: Case?) {
        goToBrkdwnFlw1Stp5ServiceDetail(towTruck: false, service: nil, appointment: appointment)
    }
    
    func presentCalendar(delegate: CalendarViewControllerDelegate) {
        let controller: CalendarViewController = UIStoryboard(storyboard: .services).instantiateViewController()
        let viewModel = CalendarViewModel()
        controller.viewModel = viewModel
        controller.delegate = delegate
        navigationController.present(controller, animated: true)
    }
}

extension BreakDownCoordinator: ServicesVMCoordinatorDelegate {
    
    func presentFilters(services: [Supplier], delegate: ServiceFilterViewControllerDelegate) {
        let controller: ServiceFilterViewController = UIStoryboard(storyboard: .vehicle).instantiateViewController()
        let viewModel = ServiceFilterViewModel()
        controller.viewModel = viewModel
        viewModel.services = services
        controller.delegate = delegate
        navigationController.present(controller, animated: true)
    }
    
    func goToServiceDetail(service: Supplier?, appointment: Case?, tireSupportType: TireSupportType?, towTruck: Bool) {
    }
}

// MARK: FLOW 2 AND 3
extension BreakDownCoordinator: BrkdwnFlw2Stp2AnyAlarmVMCrdinatorDlgt,
                                BrkdwnFlw2Stp3WarningLightsVMCrdntrDlgt,
                                BrkdnFlw2Stp4SelectedWrnngsVMCrdntrDlgt,
                                WarningLightsViewModelVMCrdntrDlgt {
    
    func goToBreakdownFlow2Step2AnyAlarm() {
        let controller: BrkdwnFlw2Stp2AnyAlarmVController = storyboard.instantiateViewController()
        controller.viewModel = BrkdwnFlw2Stp2AnyAlarmViewModel()
        controller.viewModel.coordinatorDelegate = self
        navigationController.pushViewController(controller, animated: true)
    }
    
    func goToBrkdwnFlw2Stp3WarningLights() {
        let controller: BrkdwnFlw2Stp3WarningLightsVController = storyboard.instantiateViewController()
        controller.viewModel = BrkdwnFlw2Stp3WarningLightsViewModel()
        controller.viewModel.coordinatorDelegate = self
        navigationController.pushViewController(controller, animated: true)
    }
    
    func goToBrkdwnFlw2Stp4SelectedWarnings(item: MockWarning, allWarnings: [MockWarning]) {
        let controller: BrkdwnFlw2Stp4SelectedWarningsVCntlr = storyboard.instantiateViewController()
        let viewModel = BrkdwnFlw2Stp4SelectedWarningsViewModel()
        viewModel.coordinatorDelegate = self
//        viewModel.warnings = [item]
        viewModel.allWarninggs = allWarnings
        controller.viewModel = viewModel
        navigationController.pushViewController(controller, animated: true)
    }
    
    func goToWarningLights(delegate: WarningLightsViewControllerDelegate, warnings: [MockWarning]) {
        let controller: WarningLightsViewController = storyboard.instantiateViewController()
        controller.viewModel = WarningLightsViewModel()
        controller.viewModel.coordinatorDelegate = self
        controller.delegate = delegate
        controller.viewModel.warnings = warnings
        navigationController.pushViewController(controller, animated: true)
    }
}

// MARK: Flow 4
extension BreakDownCoordinator: BrkdwnFlw4Stp3NoWarningVMCrdntrDlgt {
    func goToBrkdwnFlw4Stp3NoWarning() {
        let controller: BrkdwnFlw4Stp3NoWarningVController = storyboard.instantiateViewController()
        controller.viewModel = BrkdwnFlw4Stp3NoWarningViewModel()
        controller.viewModel.coordinatorDelegate = self
        navigationController.pushViewController(controller, animated: true)
    }
}

extension BreakDownCoordinator: WarningGuideVMCrdntrDlgt {
   
    func goToWarningGuide() {
//        let controller: WarningGuideViewController = storyboard.instantiateViewController()
//        controller.viewModel = WarningGuideViewModel()
//        controller.viewModel.coordinatorDelegate = self
//        navigationController.pushViewController(controller, animated: true)
        
        if let urlDestination = Bundle.main.url(forResource: "warningLightGuide", withExtension: "pdf") {
            guard let pdf = PDFDocument(url: urlDestination) else { return }
//            let title = App.getString(key: "copilotapp.accidentdamage.declaration.form.example.button") ?? ""
            let title = Strings.breakdownWarningLightGuide
        
            let viewController: PdfViewerViewController = UIStoryboard(storyboard: .vehicle).instantiateViewController()
            viewController.viewModel = PdfViewerViewModel()
            viewController.viewModel.pdfDoc = pdf
            viewController.viewModel.coordinatorDelegate = self
            viewController.viewModel.title = title
            navigationController.pushViewController(viewController, animated: true)
            
        }
    }
    
    func getBackToBreakdown() {
        for item in navigationController.viewControllers where item.isKind(of: BreakDownViewController.self) {
                navigationController.popToViewController(item, animated: true)
                return
        }
        
        navigationController.popToRootViewController(animated: true)
    }
}

extension BreakDownCoordinator: PdfViewerViewModelCoordinatorDelegate {
    
}
