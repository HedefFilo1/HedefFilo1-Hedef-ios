//
//  MainCoordinator.swift
//  Copilot
//
//  Created by Jamal on 10/9/23.
//

import Foundation
import UIKit

protocol MainCoordinatorDelegate: AnyObject {
    func didFinish(from coordinator: Coordinator)
}

class MainCoordinator: Coordinator {
    
    let navigationController: UINavigationController
    let storyboard = UIStoryboard(storyboard: .main)
    weak var delegate: MainCoordinatorDelegate?
    static var current: MainCoordinator?
    
    var tabBarController: MainTabBarController?
    var menuViewController: MenuViewController?
    var documentPopupViewController: DocumentPopupViewController?
    
    lazy var viewModel: MainViewModel = {
        let viewModel = MainViewModel()
        viewModel.coordinatorDelegate = self
        return viewModel
    }()
    
    lazy var documentsViewModel: DocumentsViewModel = {
        let viewModel = DocumentsViewModel()
        viewModel.coordinatorDelegate = self
        return viewModel
    }()
    
    init(with navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.isNavigationBarHidden = true
        super.init()
        Self.current = self
    }
    
    override func start() {
        let viewController: MainTabBarController = storyboard.instantiateViewController()
        viewController.viewModel = viewModel
        navigationController.pushViewController(viewController, animated: true)
        tabBarController = viewController
    }
    
    override func finish() {
        navigationController.popToRootViewController(animated: true)
        delegate?.didFinish(from: self)
    }
}

extension MainCoordinator: MainViewModelCoordinatorDelegate {
    
    func getBack() {
        navigationController.popViewController(animated: true)
    }
    
    func showMenu() {
        let viewController: MenuViewController = storyboard.instantiateViewController()
        viewController.viewModel = MenuViewModel()
        viewController.viewModel.coordinatorDelegate = self
        navigationController.present(viewController, animated: true)
//        navigationController.pushViewController(viewController, animated: true)
        menuViewController = viewController
    }
}

extension MainCoordinator: MenuViewModelCoordinatorDelegate {
    func hideMenu() {
        menuViewController?.dismiss(animated: true)
    }
    
    func showProfile() {
        tabBarController?.setSelectedIndex(index: 5)
    }
    
    func showCampaigns() {
        tabBarController?.setSelectedIndex(index: 6)
        if let controller = tabBarController?.viewControllers?[6] as? CampaignsViewController {
            controller.viewModel = CampaignsViewModel()
            controller.viewModel.coordinatorDelegate = self
        }
    }
    
    func showDocuments() {
        tabBarController?.setSelectedIndex(index: 7)
        if let controller = tabBarController?.viewControllers?[7] as? DocumentsViewController {
            controller.viewModel = documentsViewModel
            controller.viewModel.coordinatorDelegate = self
        }
    }
    
    func showVehicleInfo() {
        tabBarController?.setSelectedIndex(index: 8)
//        if let navigation = tabBarController?.viewControllers?[8] as? UINavigationController,
////        let controller = navigation.viewControllers[0] as? VehicleInfoViewController {
////            controller.viewModel = VehicleInfoViewModel()
////            let coordinator = VehicleCoordinator(with: navigationController)
////            controller.viewModel.coordinatorDelegate = coordinator
////            addChildCoordinator(coordinator)
////        }
    }
    
    func showVehicleHGS() {
        tabBarController?.setSelectedIndex(index: 9)
    }
}

extension MainCoordinator: CampaignsViewModelCoordinatorDelegate {
    func goToCampaignDetail(campaign: Campaign) {
        let viewController: CampaignDetailViewController = storyboard.instantiateViewController()
        viewController.viewModel = CampaignDetailViewModel()
        viewController.viewModel.campaign = campaign
        viewController.viewModel.coordinatorDelegate = self
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension MainCoordinator: DocumentsViewModelCoordinatorDelegate, DocumentViewModelCoordinatorDelegate {
    func goToDocument(document: Document) {
//        let viewController: DocumentViewController = storyboard.instantiateViewController()
//        viewController.viewModel = DocumentViewModel()
//        viewController.viewModel.coordinatorDelegate = self
//        navigationController.pushViewController(viewController, animated: true)
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

extension MainCoordinator: PdfViewerViewModelCoordinatorDelegate {
    
}

extension MainCoordinator: DocumentPopupVMCoordinatorDelegate {
    
    func dismiss(_: DocumentPopupViewModelType, deletedDocument: Document?) {
        documentPopupViewController?.dismiss(animated: true) {[weak self]  in
            if let doc = deletedDocument {
                self?.documentsViewModel.delete(document: doc)
            }
        }
    }
}

extension MainCoordinator: CampaignDetailVMCoordinatorDelegate {
    
}
