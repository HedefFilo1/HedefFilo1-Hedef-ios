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
    
    lazy var supportTabViewController = {
        let controller = UIViewController()
        controller.view.backgroundColor = .white
        return controller
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
            supportTabViewController,
            menuCoordinator.navigationController
        ]
        addChildCoordinator(homeCoordinator)
        tabBarController.selectedIndex = 2
        
#if DEV_DEBUG
        // just for test
        tabBarController.selectedIndex = 0
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
