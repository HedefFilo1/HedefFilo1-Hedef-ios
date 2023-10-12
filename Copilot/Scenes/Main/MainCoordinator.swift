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
    
    var menuViewController: MenuViewController?
    
    lazy var viewModel: MainViewModel = {
        let viewModel = MainViewModel()
        viewModel.coordinatorDelegate = self
        return viewModel
    }()
    
    init(with navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() {
        let viewController: MainTabBarController = storyboard.instantiateViewController()
        viewController.viewModel = viewModel
        navigationController.pushViewController(viewController, animated: true)
    }
    
    override func finish() {
        navigationController.popToRootViewController(animated: true)
        delegate?.didFinish(from: self)
    }
}

extension MainCoordinator: MainViewModelCoordinatorDelegate {
    
    func getBack() {
        finish()
    }
    
    func showMenu() {
        let viewController: MenuViewController = storyboard.instantiateViewController()
        viewController.viewModel = MenuViewModel()
        viewController.viewModel.coordinatorDelegate = self
        navigationController.present(viewController, animated: true)
        menuViewController = viewController
    }
}

extension MainCoordinator: MenuViewModelCoordinatorDelegate {
    func hideMenu() {
        menuViewController?.dismiss(animated: true)
    }
}
