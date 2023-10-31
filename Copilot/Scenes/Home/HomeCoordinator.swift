//
//  HomeCoordinator.swift
//  Copilot
//
//  Created by Jamal on 10/10/23.
//

import Foundation
import UIKit

protocol HomeCoordinatorDelegate: AnyObject {
    func didFinish(from coordinator: Coordinator)
}

class HomeCoordinator: Coordinator {
    
    let navigationController: UINavigationController
    let storyboard = UIStoryboard(storyboard: .home)
    weak var delegate: HomeCoordinatorDelegate?
    
    var filtersViewController: FiltersViewController?
    var kmUsedViewController: KMUsedViewController?
    
    var homeViewModel: HomeViewModel {
        let viewModel = HomeViewModel()
        viewModel.coordinatorDelegate = self
        return viewModel
    }
    
    init(with navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Coordinator
    override func start() {
        
    }
    
    override func finish() {
        delegate?.didFinish(from: self)
    }
    
}

extension HomeCoordinator: HomeViewModelCoordinatorDelegate {
    
    func goToNearMe() {
        let viewController: NearMeViewController = storyboard.instantiateViewController()
        let viewModel = NearMeViewModel()
        viewController.viewModel = viewModel
        viewModel.coordinatorDelegate = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func goToStandings() {
        let viewController: StandingsViewController = storyboard.instantiateViewController()
        let viewModel = StandingsViewModel()
        viewController.viewModel = viewModel
        viewModel.coordinatorDelegate = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func presentKMUsed() {
        let viewController: KMUsedViewController = storyboard.instantiateViewController()
        let viewModel = KMUsedViewModel()
        viewController.viewModel = viewModel
        viewModel.coordinatorDelegate = self
        viewController.viewModel = viewModel
        kmUsedViewController = viewController
        navigationController.present(viewController, animated: true)
    }
}

extension HomeCoordinator: NearMeViewModelCoordinatorDelegate {
    func getBack() {
        navigationController.popViewController(animated: true)
    }
    
    func presentFilters() {
        let viewController: FiltersViewController = storyboard.instantiateViewController()
        let viewModel = FiltersViewModel()
        viewController.viewModel = viewModel
        viewModel.coordinatorDelegate = self
        viewController.viewModel = viewModel
        filtersViewController = viewController
        navigationController.present(viewController, animated: true)
    }
}

extension HomeCoordinator: StandingsViewModelCoordinatorDelegate {
    
}

extension HomeCoordinator: FiltersViewModelCoordinatorDelegate {
    func dismiss() {
        filtersViewController?.dismiss(animated: true)
    }
}

extension HomeCoordinator: KMUsedViewModelCoordinatorDelegate {
    func dismiss(_: KMUsedViewModelType) {
        kmUsedViewController?.dismiss(animated: true)
    }
}

extension HomeCoordinator {
    func didFinish(from coordinator: Coordinator) {
        removeChildCoordinator(coordinator)
    }
}
