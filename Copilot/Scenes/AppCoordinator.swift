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
        goToLogin()
//        goToMain()
    }
    
    func logout() {
        removeAllChildCoordinators()
        Persistence.accessToken = nil
//        restart()
        goToLogin()

    }
    
    func goToMain() {
        guard let window = window else {
            return
        }
        let coordinator = MainCoordinator(with: window)
        addChildCoordinator(coordinator)
        coordinator.delegate = self
        coordinator.start()
    }
}

extension AppCoordinator: SplashCoordinatorDelegate {
    
    func splashDidFinish(from coordinator: Coordinator) {
        guard let window = window else {
            return
        }
        let hasShown = Persistence.onboardingHasShown ?? false
        if  hasShown {
            restart()
            
        } else {
            let coordinator = OnboardingCoordinator(with: window)
            addChildCoordinator(coordinator)
            coordinator.delegate = self
            coordinator.start()
        }
    }
}

extension AppCoordinator: OnboardingCoordinatorDelegate, MainCoordinatorDelegate {
    
    func didFinish(from coordinator: Coordinator) {
        removeChildCoordinator(coordinator)
        restart()
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
    func loginDidFinish(from coordinator: Coordinator) {
        removeChildCoordinator(coordinator)
        goToMain()
    }
}
