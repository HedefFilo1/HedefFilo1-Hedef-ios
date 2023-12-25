//
//  SplashCoordinator.swift
//  Copilot
//
//  Created by Jamal on 9/27/23.
//

import Foundation
import UIKit

protocol SplashCoordinatorDelegate: AnyObject {
    func splashDidFinish(from coordinator: Coordinator)
}

class SplashCoordinator: Coordinator {
    
    let window: UIWindow
    
    let storyboard = UIStoryboard(storyboard: .splash)
    
    weak var delegate: SplashCoordinatorDelegate?
    
    lazy var viewModel: SplashViewModel = {
        let viewModel = SplashViewModel()
        viewModel.coordinatorDelegate = self
        return viewModel
    }()
    
    init(with window: UIWindow) {
        self.window = window
    }
    
    // MARK: - Coordinator
    override func start() {
        
        let viewController: SplashViewController = storyboard.instantiateViewController()
        viewController.viewModel = viewModel
        
        let navigation = UINavigationController(rootViewController: viewController)
        navigation.isNavigationBarHidden = true
        window.rootViewController = navigation
        window.makeKeyAndVisible()
    }
    
    override func finish() {
        delegate?.splashDidFinish(from: self)
    }
    
}

extension SplashCoordinator: SplashViewModelCoordinatorDelegate {
   
    func goToNextScene() {
        finish()
    }
}
