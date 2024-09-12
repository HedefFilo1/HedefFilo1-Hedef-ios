//
//  VehicleCoordinator.swift
//  Copilot
//
//  Created by Jamal on 11/23/23.
//

import Foundation
import UIKit
import PDFKit

protocol VehicleCoordinatorDelegate: AnyObject {
    func didFinish(from coordinator: Coordinator)
}

class VehicleCoordinator: Coordinator {
    
    let navigationController: UINavigationController 
    let storyboard = UIStoryboard(storyboard: .vehicle)
    weak var delegate: VehicleCoordinatorDelegate?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() {
        let viewController: VehicleInfoViewController = storyboard.instantiateViewController()
        viewController.viewModel = VehicleInfoViewModel()
        viewController.viewModel.coordinatorDelegate = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func startWithHGS() {
        let viewController: HGSViewController = storyboard.instantiateViewController()
        viewController.viewModel = HGSViewModel()
        viewController.viewModel.coordinatorDelegate = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func startWithServices() {
        let viewController: VehicleServicesViewController = storyboard.instantiateViewController()
        viewController.viewModel = VehicleServicesViewModel()
        viewController.viewModel.coordinatorDelegate = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    override func finish() {
        delegate?.didFinish(from: self)
    }
}

extension VehicleCoordinator: VehicleInfoViewModelCoordinatorDelegate,
                              RequestsCoordinatorDelegate {
    
    func goToDocument(document: Document) {
        
        let viewController: PdfViewerViewController = storyboard.instantiateViewController()
        viewController.viewModel = PdfViewerViewModel()
        viewController.viewModel.document = document
        viewController.viewModel.coordinatorDelegate = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func goToVehicleGuide() {
//        let viewController: PdfViewerViewController = storyboard.instantiateViewController()
//        viewController.viewModel = PdfViewerViewModel()
//        viewController.viewModel.coordinatorDelegate = self
//        navigationController.pushViewController(viewController, animated: true)
        var file = "vehicleGuideTr"
        if App.language == CodeStrings.english {
            file = "vehicleGuide"
        }
        if let urlDestination = Bundle.main.url(forResource: file, withExtension: "pdf") {
            guard let pdf = PDFDocument(url: urlDestination) else { return }
//            let title = App.getString(key: "copilotapp.accidentdamage.declaration.form.example.button") ?? ""
            let title = App.getString(key: "copilotapp.vehicle.guide") ?? ""
        
            let viewController: PdfViewerViewController = UIStoryboard(storyboard: .vehicle).instantiateViewController()
            viewController.viewModel = PdfViewerViewModel()
            viewController.viewModel.pdfDoc = pdf
            viewController.viewModel.coordinatorDelegate = self
            viewController.viewModel.title = title
            navigationController.pushViewController(viewController, animated: true)
            
        }
    }
    
    func goToRequests() {
        let coordinator = RequestsCoordinator(navigationController: navigationController)
        coordinator.delegate = self
        addChildCoordinator(coordinator)
        coordinator.start()
    }
    
    func didFinish(from coordinator: Coordinator) {
        removeChildCoordinator(coordinator)
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
    
    func getBackToMenu() {
       
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

extension VehicleCoordinator: VehicleServicesVMCoordinatorDelegate {
   
    func presentFilters(services: [Supplier], delegate: ServiceFilterViewControllerDelegate) {
        let controller: ServiceFilterViewController = storyboard.instantiateViewController()
        let viewModel = ServiceFilterViewModel()
        controller.viewModel = viewModel
        viewModel.services = services
        controller.delegate = delegate
        navigationController.present(controller, animated: true)
    }
}
