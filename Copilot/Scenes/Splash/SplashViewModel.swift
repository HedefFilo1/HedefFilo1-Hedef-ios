//
//  SplashViewModel.swift
//  Copilot
//
//  Created by Jamal on 9/27/23.
//

import Foundation
import UIKit

protocol SplashViewModelCoordinatorDelegate: AnyObject {
    func goToNextScene()
}

protocol SplashViewModelDelegate: AnyObject {
    
}

protocol SplashViewModelType: AnyObject {
    
    var coordinatorDelegate: SplashViewModelCoordinatorDelegate? { get set }
    var delegate: SplashViewModelDelegate? { get set }
    
    func start()
    func goToNextScene()
    
}

class SplashViewModel: SplashViewModelType {
    
    weak var coordinatorDelegate: SplashViewModelCoordinatorDelegate?
    weak var delegate: SplashViewModelDelegate?
    
    func start() {
        // just for test
        var deadline: DispatchTime = .now() + 2
#if DEV_DEBUG
        deadline = .now() + 0.3
#endif
        DispatchQueue.main.asyncAfter(deadline: deadline) { [weak self] in
            guard let self = self else { return }
            self.goToNextScene()
        }
    }
    
    func goToNextScene() {
        coordinatorDelegate?.goToNextScene()
    }
}
