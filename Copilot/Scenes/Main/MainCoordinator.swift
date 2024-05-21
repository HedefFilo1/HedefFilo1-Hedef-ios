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
    
    var tabBarController: MainTabBarController
    
    lazy var homeCoordinator: HomeCoordinator = {
        let coordinator = HomeCoordinator()
        coordinator.delegate = self
        coordinator.start()
        return coordinator
    }()
    
    lazy var menuCoordinator: MenuCoordinator = {
        let coordinator = MenuCoordinator()
        coordinator.delegate = self
        coordinator.start()
        return coordinator
    }()
    
    lazy var servicesCoordinator: ServicesCoordinator = {
        let coordinator = ServicesCoordinator()
        coordinator.delegate = self
        coordinator.start()
        return coordinator
    }()
    
    lazy var accidentCoordinator: AccidentCoordinator = {
        let coordinator = AccidentCoordinator()
        coordinator.delegate = self
        coordinator.start()
        return coordinator
    }()
    
    lazy var mainViewModel: MainViewModel = {
        let viewModel = MainViewModel()
        viewModel.coordinatorDelegate = self
        return viewModel
    }()
    
    lazy var supportTabCoordinator: UIViewController = {
        let coordinator = UIViewController()
        //        coordinator.delegate = self
        //        coordinator.start()
        coordinator.view.backgroundColor = .white
        return coordinator
    }()
    
    lazy var supportCoordinator: SupportCoordinator = {
        let coordinator = SupportCoordinator()
        coordinator.delegate = self
        coordinator.start()
        return coordinator
    }()
    
    init(with window: UIWindow) {
        self.window = window
        let tabBarController: MainTabBarController = storyboard.instantiateViewController()
        self.tabBarController = tabBarController
    }
    
    override func start() {
        tabBarController.viewModel = mainViewModel
        
        tabBarController.viewControllers = [
            accidentCoordinator.navigationController,
            servicesCoordinator.navigationController,
            homeCoordinator.navigationController,
            supportCoordinator.navigationController,
            menuCoordinator.navigationController
        ]
        addChildCoordinator(homeCoordinator)
        homeCoordinator.mainCoordinator = self
#if DEV_DEBUG
        // just for test
        tabBarController.selectedIndex = 3
#else
        tabBarController.selectedIndex = 2
#endif
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        tabBarController.setupTabBarView()
    }
    
    override func finish() {
        delegate?.didFinish(from: self)
    }
    
}

extension MainCoordinator: HomeCoordinatorDelegate,
                           ServicesCoordinatorDelegate,
                           MenuCoordinatorDelegate,
                           AccidentCoordinatorDelegate {
    
    func didFinish(from coordinator: Coordinator) {
        removeChildCoordinator(coordinator)
        finish()
    }
}

extension MainCoordinator: MainViewModelCoordinatorDelegate {
    
}

extension MainCoordinator: SearchViewModelCoordinatorDelegate {
    
    func getBack() {
        homeCoordinator.navigationController.popViewController(animated: true)
    }
    
    func goToMenu() {
        homeCoordinator.navigationController.select(tab: 4)
    }
    
    func goToSupport() {
        homeCoordinator.navigationController.select(tab: 3)
    }
    
    func goToService() {
        homeCoordinator.navigationController.select(tab: 1)
    }
    
    func goToAccident() {
        homeCoordinator.navigationController.select(tab: 0)
    }
    
    func goToSettings() {
        homeCoordinator.navigationController.select(tab: 4)
        menuCoordinator.showSettings()
    }
    
    func goToGuides() {
        homeCoordinator.navigationController.select(tab: 3)
        supportCoordinator.goToSupportGuide()
    }
    
    func goToFeedback() {
        homeCoordinator.navigationController.select(tab: 3)
        supportCoordinator.goToFeedback()
    }
    
    func goToFAQ() {
        homeCoordinator.navigationController.select(tab: 3)
        supportCoordinator.goToFAQ()
    }
    
    func goToCallCenter() {
        homeCoordinator.navigationController.select(tab: 3)
        supportCoordinator.goToSupportGuide()
    }
}

extension MainCoordinator: SupportCoordinatorDelegate {
    func supportDidFinish(from coordinator: SupportCoordinator) {
        removeChildCoordinator(coordinator)
    }
}
