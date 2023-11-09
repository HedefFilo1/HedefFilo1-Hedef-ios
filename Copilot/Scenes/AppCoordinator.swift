//
//  AppCoordinator.swift
//  Copilot
//
//  Created by Jamal on 9/27/23.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    
    // MARK: - Variables
    let window: UIWindow?
    
    // MARK: - Coordinator
    init(window: UIWindow?) {
        self.window = window
    }
    
    override func start() {
        guard let window = window else {
            return
        }
        window.overrideUserInterfaceStyle = .light
        App.appCoordinator = self
        
        let coordinator = SplashCoordinator(with: window)
        coordinator.delegate = self
        coordinator.start()
        addChildCoordinator(coordinator)
    }
    
    override func finish() { }
    
    func logout() {
        if let coordinator = childCoordinator(type: LoginCoordinator.self) {
            coordinator.removeAllChildCoordinators()
        }
        Persistence.accessToken = nil
        if let nav = window?.rootViewController as? UINavigationController {
            for ctrl in nav.viewControllers where ctrl is LoginViewController {
                nav.popToViewController(ctrl, animated: true)
            }
        }
    }
}

extension AppCoordinator: SplashCoordinatorDelegate {
    
    func goNextScene() {
        guard let window = window else {
            return
        }
        let hasShown = Persistence.onboardingHasShown ?? false
        if  hasShown {
            goToLogin()
            
        } else {
            let coordinator = OnboardingCoordinator(with: window)
            addChildCoordinator(coordinator)
            coordinator.delegate = self
            coordinator.start()
        }
    }
}

extension AppCoordinator: OnboardingCoordinatorDelegate {
    
    func didFinish(from coordinator: Coordinator) {
        removeChildCoordinator(coordinator)
    }
    
    func goToLogin() {
        guard let window = window else { return }
        let coordinator = LoginCoordinator(with: window)
        addChildCoordinator(coordinator)
        coordinator.delegate = self
        coordinator.start()
    }
    
    func goToSignup() {
        guard let window = window else { return }
        let coordinator = LoginCoordinator(with: window)
        addChildCoordinator(coordinator)
        coordinator.delegate = self
        coordinator.startWithSignup()
    }
}

extension AppCoordinator: LoginCoordinatorDelegate {
    
}
