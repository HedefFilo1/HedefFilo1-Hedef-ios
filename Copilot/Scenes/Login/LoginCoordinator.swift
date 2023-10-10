//
//  LoginCoordinator.swift
//  Copilot
//
//  Created by Jamal on 9/29/23.
//

import Foundation
import UIKit

protocol LoginCoordinatorDelegate: AnyObject {
    func didFinish(from coordinator: Coordinator)
}

class LoginCoordinator: Coordinator {
    
    let window: UIWindow
    let navigationController: UINavigationController
    let storyboard = UIStoryboard(storyboard: .login)
    weak var delegate: LoginCoordinatorDelegate?
    
    var loginViewModel: LoginViewModel {
        let viewModel = LoginViewModel()
        viewModel.coordinatorDelegate = self
        return viewModel
    }
    
    init(with window: UIWindow) {
        self.window = window
        navigationController = UINavigationController()
        navigationController.isNavigationBarHidden = true
    }
    
    // MARK: - Coordinator
    override func start() {
        let viewController: LoginViewController = storyboard.instantiateViewController()
        viewController.viewModel = loginViewModel
        navigationController.viewControllers = [viewController]
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func startWithSignup() {
        start()
        goToSignup()
    }
    
    override func finish() {
        delegate?.didFinish(from: self)
    }
    
}

extension LoginCoordinator: LoginViewModelCoordinatorDelegate {
    
    func goToForgotPassword() {
        let viewController: ForgotPasswordViewController = storyboard.instantiateViewController()
        let viewModel = ForgotPasswordViewModel()
        viewController.viewModel = viewModel
        viewModel.coordinatorDelegate = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func goToMain() {
        let coordinator = MainCoordinator(with: navigationController)
        addChildCoordinator(coordinator)
        coordinator.delegate = self
        coordinator.start()
    }
    
    func goToSignup() {
        let viewController: SignupViewController = storyboard.instantiateViewController()
        let viewModel = SignupViewModel()
        viewController.viewModel = viewModel
        viewModel.coordinatorDelegate = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
}

extension LoginCoordinator: SignupViewModelCoordinatorDelegate {
    func goToLogin() {
        navigationController.popViewController(animated: true)
    }
}

extension LoginCoordinator: ForgotPasswordVMCoordinatorDelegate {
    func getBack() {
        navigationController.popViewController(animated: true)
    }
}

extension LoginCoordinator: MainCoordinatorDelegate {
    func didFinish(from coordinator: Coordinator) {
        removeChildCoordinator(coordinator)
    }
}
