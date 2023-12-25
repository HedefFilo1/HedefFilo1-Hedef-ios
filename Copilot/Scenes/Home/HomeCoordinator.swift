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
    
    lazy var navigationController: UINavigationController = {
        let navVC = UINavigationController()
        return navVC
    }()
    
    let storyboard = UIStoryboard(storyboard: .home)
    weak var delegate: HomeCoordinatorDelegate?
    
    var filtersViewController: FiltersViewController?
    var kmUsedViewController: KMUsedViewController?
    
    var homeViewModel: HomeViewModel {
        let viewModel = HomeViewModel()
        viewModel.coordinatorDelegate = self
        return viewModel
    }
    
    // MARK: - Coordinator
    override func start() {
        let viewController: HomeViewController = storyboard.instantiateViewController()
        viewController.viewModel = homeViewModel
        navigationController.setViewControllers([viewController], animated: true)
    }
    
    override func finish() {
        delegate?.didFinish(from: self)
    }
    
}

extension HomeCoordinator: HomeViewModelCoordinatorDelegate {
    
    func goToNearMe(mark: String) {
        let viewController: NearMeViewController = storyboard.instantiateViewController()
        let viewModel = NearMeViewModel()
        viewController.viewModel = viewModel
        viewModel.coordinatorDelegate = self
        viewModel.mark = mark
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func goToStandings() {
        let viewController: StandingsViewController = storyboard.instantiateViewController()
        let viewModel = StandingsViewModel()
        viewController.viewModel = viewModel
        viewModel.coordinatorDelegate = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func presentKMUsed(delegate: KMUsedViewControllerDelegate) {
        let viewController: KMUsedViewController = storyboard.instantiateViewController()
        let viewModel = KMUsedViewModel()
        viewController.viewModel = viewModel
        viewModel.coordinatorDelegate = self
        viewController.viewModel = viewModel
        kmUsedViewController = viewController
        viewController.delegate = delegate
        navigationController.present(viewController, animated: true)
    }
    
    func goToSearch() {
        let viewController: SearchViewController = storyboard.instantiateViewController()
        let viewModel = SearchViewModel()
        viewController.viewModel = viewModel
        viewModel.coordinatorDelegate = self
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension HomeCoordinator: NearMeViewModelCoordinatorDelegate, SearchViewModelCoordinatorDelegate {
    func getBack() {
        navigationController.popViewController(animated: true)
    }
    
    func presentFilters(delegate: FiltersViewControllerDelegate) {
        let viewController: FiltersViewController = storyboard.instantiateViewController()
        let viewModel = FiltersViewModel()
        viewController.viewModel = viewModel
        viewModel.coordinatorDelegate = self
        viewController.viewModel = viewModel
        filtersViewController = viewController
        viewController.delegate = delegate
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
