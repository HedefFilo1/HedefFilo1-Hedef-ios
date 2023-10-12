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
    
}

extension HomeCoordinator {
    func didFinish(from coordinator: Coordinator) {
        removeChildCoordinator(coordinator)
    }
}
