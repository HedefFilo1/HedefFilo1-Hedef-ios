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

protocol SplashViewModelDelegate: BaseViewModelDelegate {
    
}

protocol SplashViewModelType: AnyObject {
    
    var coordinatorDelegate: SplashViewModelCoordinatorDelegate? { get set }
    var delegate: SplashViewModelDelegate? { get set }
    
    func start()
    func goToNextScene()
    func verifyToken()
}

class SplashViewModel: SplashViewModelType {
    
    weak var coordinatorDelegate: SplashViewModelCoordinatorDelegate?
    weak var delegate: SplashViewModelDelegate?
    
    func start() {
        // just for test
        var deadline: DispatchTime = .now() + 2
#if DEV_DEBUG
        deadline = .now() + 1
#endif
        DispatchQueue.main.asyncAfter(deadline: deadline) { [weak self] in
            guard let self = self else { return }
            self.goToNextScene()
        }
    }
    
    func verifyToken() {
        guard let token = Persistence.accessToken, token.count > 3 else {
            self.loadStrings()
            return
        }
        App.token = token
        APIService.verifyToken { [weak self] _, error in
            
            guard let self = self else {return}
            
            if error != nil {
                Persistence.accessToken = nil
            }
            self.loadStrings()
        }
    }
    
    func loadStrings() {
        APIService.getStrings { [weak self] model, error in
            
            guard let self = self else { return }
            
            if let error {
                self.delegate?.showError(title: Strings.errorTitle, message: error.message)
            }
            
            if let model = model {
                App.contentStrings = model
                self.getSessionId()
            }
            
            #if DEV_DEBUG
            self.goToNextScene()
            #endif
        }
    }
    
    func getSessionId() {
//        Loading.shared.show(title: Strings.loading)
        APIService.getSessionId { [weak self] model, error in
            
//            Loading.shared.hide()
            guard let self = self else {return}
            
            if let error = error {
                print(error)
            }
            
            if let model = model {
                App.sessionId = model.sessionId
            }
            self.goToNextScene()
        }
        
    }
    
    func goToNextScene() {
        coordinatorDelegate?.goToNextScene()
    }
}
