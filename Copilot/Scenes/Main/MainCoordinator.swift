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
    
    let window: UIWindow
    let storyboard = UIStoryboard(storyboard: .main)
    weak var delegate: MainCoordinatorDelegate?
    static var current: MainCoordinator?
    
    var tabBarController: MainTabBarController?
    var documentPopupViewController: DocumentPopupViewController?
    
    lazy var homeCoordinator: HomeCoordinator = {
        let coordinator = HomeCoordinator()
        coordinator.delegate = self
        coordinator.start()
        return coordinator
    }()
    
    lazy var profileCoordinator: ProfileCoordinator = {
        let coordinator = ProfileCoordinator()
        coordinator.delegate = self
        coordinator.start()
        return coordinator
    }()
    
    lazy var vehicleCoordinator: VehicleCoordinator = {
        let coordinator = VehicleCoordinator()
        coordinator.delegate = self
        coordinator.start()
        return coordinator
    }()
    
    lazy var hgsCoordinator: VehicleCoordinator = {
        let coordinator = VehicleCoordinator()
        coordinator.delegate = self
        coordinator.startWithHGS()
        return coordinator
    }()
    
    lazy var vehicleServicesCoordinator: VehicleCoordinator = {
        let coordinator = VehicleCoordinator()
        coordinator.delegate = self
        coordinator.startWithServices()
        return coordinator
    }()
    
    lazy var mainViewModel: MainViewModel = {
        let viewModel = MainViewModel()
        viewModel.coordinatorDelegate = self
        return viewModel
    }()
    
    lazy var documentsViewModel: DocumentsViewModel = {
        let viewModel = DocumentsViewModel()
        viewModel.coordinatorDelegate = self
        return viewModel
    }()
    
    lazy var carTabViewController = {
        let controller = UIViewController()
        controller.view.backgroundColor = .white
        return controller
    }()
    
    lazy var serviceTabViewController = {
        let controller = UIViewController()
        controller.view.backgroundColor = .white
        return controller
    }()
    
    lazy var supportTabViewController = {
        let controller = UIViewController()
        controller.view.backgroundColor = .white
        return controller
    }()
    
    lazy var menuViewController: MenuViewController = {
        let viewController: MenuViewController = storyboard.instantiateViewController()
        viewController.viewModel = MenuViewModel()
        viewController.viewModel.coordinatorDelegate = self
        return viewController
    }()
    
    lazy var campaignsViewController: UINavigationController = {
        let navigation = UINavigationController()
        let viewController: CampaignsViewController = storyboard.instantiateViewController()
        viewController.viewModel = CampaignsViewModel()
        viewController.viewModel.coordinatorDelegate = self
        navigation.setViewControllers([viewController], animated: true)
        return navigation
    }()
    
    lazy var documentsViewController: UINavigationController = {
        let navigation = UINavigationController()
        let viewController: DocumentsViewController = storyboard.instantiateViewController()
        viewController.viewModel = DocumentsViewModel()
        viewController.viewModel.coordinatorDelegate = self
        navigation.setViewControllers([viewController], animated: true)
        return navigation
    }()
    
    init(with window: UIWindow) {
        self.window = window
    }
    
    override func start() {
        let tabbarController: MainTabBarController = storyboard.instantiateViewController()
        tabbarController.viewModel = mainViewModel
        
        tabbarController.viewControllers = [
            carTabViewController,
            serviceTabViewController,
            homeCoordinator.navigationController,
            supportTabViewController,
            menuViewController,
            profileCoordinator.navigationController,
            campaignsViewController,
            documentsViewController,
            vehicleCoordinator.navigationController,
            hgsCoordinator.navigationController,
            vehicleServicesCoordinator.navigationController
            
        ]
        addChildCoordinator(homeCoordinator)
        addChildCoordinator(profileCoordinator)
        tabbarController.selectedIndex = 2
        
#if DEV_DEBUG
        // just for test
        tabbarController.selectedIndex = 2
#endif
        self.tabBarController = tabbarController
        window.rootViewController = tabbarController
        window.makeKeyAndVisible()
    }
    
    override func finish() {
        delegate?.didFinish(from: self)
    }
}

extension MainCoordinator: HomeCoordinatorDelegate,
                           ProfileCoordinatorDelegate,
                           VehicleCoordinatorDelegate {
    func didFinish(from coordinator: Coordinator) {
        removeChildCoordinator(coordinator)
        finish()
    }
}

extension MainCoordinator: MainViewModelCoordinatorDelegate {
    
}

extension MainCoordinator: MenuViewModelCoordinatorDelegate {
    
    func showProfile() {
        tabBarController?.setSelectedIndex(index: 5)
    }
    
    func showCampaigns() {
        tabBarController?.setSelectedIndex(index: 6)
    }
    
    func showDocuments() {
        tabBarController?.setSelectedIndex(index: 7)
    }
    
    func showVehicleInfo() {
        tabBarController?.setSelectedIndex(index: 8)
    }
    
    func showVehicleHGS() {
        tabBarController?.setSelectedIndex(index: 9)
    }
    
    func showServices() {
        tabBarController?.setSelectedIndex(index: 10)
    }
}

extension MainCoordinator: CampaignsViewModelCoordinatorDelegate {
    func goToCampaignDetail(campaign: Campaign) {
        let viewController: CampaignDetailViewController = storyboard.instantiateViewController()
        viewController.viewModel = CampaignDetailViewModel()
        viewController.viewModel.campaign = campaign
        viewController.viewModel.coordinatorDelegate = self
        campaignsViewController.pushViewController(viewController, animated: true)
    }
}

extension MainCoordinator: DocumentsViewModelCoordinatorDelegate, DocumentViewModelCoordinatorDelegate {
    func goToDocument(document: Document) {
        let viewController: PdfViewerViewController = UIStoryboard(storyboard: .vehicle).instantiateViewController()
        viewController.viewModel = PdfViewerViewModel()
        viewController.viewModel.document = document
        viewController.viewModel.coordinatorDelegate = self
        documentsViewController.pushViewController(viewController, animated: true)
    }
    
    func presentDocumentPopup(document: Document) {
        let viewController: DocumentPopupViewController = storyboard.instantiateViewController()
        let viewModel = DocumentPopupViewModel()
        viewController.viewModel = viewModel
        viewModel.coordinatorDelegate = self
        viewController.viewModel = viewModel
        viewModel.document = document
        documentPopupViewController = viewController
        documentsViewController.present(viewController, animated: true)
    }
}

extension MainCoordinator: PdfViewerViewModelCoordinatorDelegate {
    func getBack() {
        
    }
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
