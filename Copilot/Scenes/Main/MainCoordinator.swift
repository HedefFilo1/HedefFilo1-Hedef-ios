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
            
            //            marketCoordinator.rootNavigationController,
            //            homeCoordinator.rootNavigationController,
            //            servicesCoordinator.rootNavigationController
        ]
        addChildCoordinator(homeCoordinator)
        addChildCoordinator(profileCoordinator)
        tabbarController.selectedIndex = 2
        self.tabBarController = tabbarController
        window.rootViewController = tabbarController
        window.makeKeyAndVisible()
    }
    
    //    override func start() {
    //        let viewController: MainTabBarController = storyboard.instantiateViewController()
    //        viewController.viewModel = viewModel
    //        navigationController.pushViewController(viewController, animated: true)
    //        tabBarController = viewController
    //    }
    
    override func finish() {
        delegate?.didFinish(from: self)
    }
}

extension MainCoordinator: HomeCoordinatorDelegate, ProfileCoordinatorDelegate {
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
        //        let viewController: DocumentViewController = storyboard.instantiateViewController()
        //        viewController.viewModel = DocumentViewModel()
        //        viewController.viewModel.coordinatorDelegate = self
        //        navigationController.pushViewController(viewController, animated: true)
        let viewController: PdfViewerViewController = UIStoryboard(storyboard: .vehicle).instantiateViewController()
        viewController.viewModel = PdfViewerViewModel()
        viewController.viewModel.document = document
        viewController.viewModel.coordinatorDelegate = self
        //        navigationController.pushViewController(viewController, animated: true)
    }
    
    func presentDocumentPopup(document: Document) {
        let viewController: DocumentPopupViewController = storyboard.instantiateViewController()
        let viewModel = DocumentPopupViewModel()
        viewController.viewModel = viewModel
        viewModel.coordinatorDelegate = self
        viewController.viewModel = viewModel
        viewModel.document = document
        documentPopupViewController = viewController
        //        navigationController.present(viewController, animated: true)
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
