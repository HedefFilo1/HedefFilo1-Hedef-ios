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
    
    func restart() {
        removeAllChildCoordinators()
        App.appCoordinator = self
        goToLogin()
    }
    
//    func alert(title: String, message: String) {
//        guard let window = window else { return }
//        window.rootViewController?.showError(title: Strings.error, message: message)
//    }
}

extension AppCoordinator: SplashCoordinatorDelegate {
    
    func goNextScene() {
        guard let window = window else {
            return
        }
        
        let coordinator = OnboardingCoordinator(with: window)
        addChildCoordinator(coordinator)
        coordinator.delegate = self
        coordinator.start()
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
}

extension AppCoordinator: LoginCoordinatorDelegate {
    
}
