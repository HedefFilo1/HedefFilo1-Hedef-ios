//
//  MenuCoordinator.swift
//  Copilot
//
//  Created by Jamal on 12/25/23.
//

import Foundation
import UIKit

protocol MenuCoordinatorDelegate: AnyObject {
    func didFinish(from coordinator: Coordinator)
}

class MenuCoordinator: Coordinator {
    
    lazy var navigationController: UINavigationController = {
        let navVC = UINavigationController()
        return navVC
    }()
    
    let storyboard = UIStoryboard(storyboard: .main)
    weak var delegate: MenuCoordinatorDelegate?
    var documentPopupViewController: DocumentPopupViewController?
    var documentsViewModel: DocumentsViewModel?
    
    var menuViewModel: MenuViewModel {
        let viewModel = MenuViewModel()
        viewModel.coordinatorDelegate = self
        return viewModel
    }
    
    override func start() {
        let viewController: MenuViewController = storyboard.instantiateViewController()
        viewController.viewModel = menuViewModel
        navigationController.pushViewController(viewController, animated: true)
        
    }
    
    override func finish() {
        delegate?.didFinish(from: self)
    }
    
}

extension MenuCoordinator: MenuViewModelCoordinatorDelegate {
    func showProfile() {
        let coordinator = ProfileCoordinator(navigationController: navigationController)
        coordinator.delegate = self
        addChildCoordinator(coordinator)
        coordinator.start()
        
    }
    
    func showCampaigns() {
        let viewController: CampaignsViewController = storyboard.instantiateViewController()
        viewController.viewModel = CampaignsViewModel()
        viewController.viewModel.coordinatorDelegate = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func showDocuments() {
        let viewController: DocumentLoadViewController = storyboard.instantiateViewController()
        viewController.viewModel = DocumentLoadViewModel()
        viewController.viewModel.coordinatorDelegate = self
//        documentsViewModel = viewController.viewModel
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func showVehicleInfo() {
        let coordinator = VehicleCoordinator(navigationController: navigationController)
        coordinator.delegate = self
        addChildCoordinator(coordinator)
        coordinator.start()
    }
    
    func showVehicleHGS() {
        let coordinator = VehicleCoordinator(navigationController: navigationController)
        coordinator.delegate = self
        addChildCoordinator(coordinator)
        coordinator.startWithHGS()
    }
    
    func showRequests() {
        let coordinator = RequestsCoordinator(navigationController: navigationController)
        coordinator.delegate = self
        addChildCoordinator(coordinator)
        coordinator.start()
    }
    
    func showServices() {
        let coordinator = VehicleCoordinator(navigationController: navigationController)
        coordinator.delegate = self
        addChildCoordinator(coordinator)
        coordinator.startWithServices()
    }
    
    func showSettings() {
        let coordinator = SettingsCoordinator(navigationController: navigationController)
        coordinator.delegate = self
        addChildCoordinator(coordinator)
        coordinator.start()
    }
    
    func presentDeleteAccount() {
        let controller: DeleteAccountViewController = UIStoryboard(storyboard: .profile).instantiateViewController()
        let viewModel = DeleteAccountViewModel()
        viewModel.coordinatorDelegate = self
        controller.viewModel = viewModel
        navigationController.present(controller, animated: true)
    }
}

extension MenuCoordinator: CampaignsViewModelCoordinatorDelegate {
    func goToCampaignDetail(campaign: Campaign) {
        let viewController: CampaignDetailViewController = storyboard.instantiateViewController()
        viewController.viewModel = CampaignDetailViewModel()
        viewController.viewModel.campaign = campaign
        viewController.viewModel.coordinatorDelegate = self
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension MenuCoordinator: CampaignDetailVMCoordinatorDelegate {
    func getBack(_: CampaignDetailViewModelType) {
        navigationController.popViewController(animated: true)
    }
}

extension MenuCoordinator: DocumentsViewModelCoordinatorDelegate,
                           DocumentViewModelCoordinatorDelegate,
                           DeleteAccountVMCoordinatorDelegate {
    func goToDocument(document: Document) {
        let viewController: PdfViewerViewController = UIStoryboard(storyboard: .vehicle).instantiateViewController()
        viewController.viewModel = PdfViewerViewModel()
        viewController.viewModel.document = document
        viewController.viewModel.coordinatorDelegate = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func presentDocumentPopup(document: Document) {
        let viewController: DocumentPopupViewController = storyboard.instantiateViewController()
        let viewModel = DocumentPopupViewModel()
        viewController.viewModel = viewModel
        viewModel.coordinatorDelegate = self
        viewController.viewModel = viewModel
        viewModel.document = document
        documentPopupViewController = viewController
        navigationController.present(viewController, animated: true)
    }
}

extension MenuCoordinator: DocumentPopupVMCoordinatorDelegate {
    
    func dismiss(_: DocumentPopupViewModelType, deletedDocument: Document?) {
        documentPopupViewController?.dismiss(animated: true) {[weak self]  in
            if let doc = deletedDocument {
                self?.documentsViewModel?.delete(document: doc)
            }
        }
    }
}

extension MenuCoordinator: PdfViewerViewModelCoordinatorDelegate {
    func getBack() {
        navigationController.popViewController(animated: true)
    }
}

extension MenuCoordinator: ProfileCoordinatorDelegate,
                           VehicleCoordinatorDelegate,
                           RequestsCoordinatorDelegate,
                           SettingsCoordinatorDelegate {
    func didFinish(from coordinator: Coordinator) {
        removeChildCoordinator(coordinator)
    }
    
}

extension MenuCoordinator: DocumentLoadViewModelCoordinatorDelegate {
    
}
