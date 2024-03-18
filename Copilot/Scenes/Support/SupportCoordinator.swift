//
//  SupportCoordinator.swift
//  Copilot
//
//  Created by Fikri Can Cankurtaran on 8.03.2024.
//

import Foundation
import UIKit

protocol SupportCoordinatorDelegate: AnyObject {
    func supportDidFinish(from coordinator: SupportCoordinator)
}

class SupportCoordinator: Coordinator {
    
    lazy var navigationController: UINavigationController = {
        let navVC = UINavigationController()
        navVC.isNavigationBarHidden = true
        return navVC
    }()
    
    let storyboard = UIStoryboard(storyboard: .support)
    
    weak var delegate: SupportCoordinatorDelegate?
    
    private lazy var supportViewModel: SupportViewModel = {
        let viewModel = SupportViewModel()
        viewModel.coordinatorDelegate = self
        return viewModel
    }()
    
    override func start() {
        let viewController: SupportViewController = storyboard.instantiateViewController()
        viewController.viewModel = supportViewModel
        navigationController.setViewControllers([viewController], animated: true)
    }
    
    override func finish() {
        delegate?.supportDidFinish(from: self)
    }
    
}

extension SupportCoordinator: SupportViewModelCoordinatorDelegate {
    func supportDidFinish() {
        finish()
    }
}
