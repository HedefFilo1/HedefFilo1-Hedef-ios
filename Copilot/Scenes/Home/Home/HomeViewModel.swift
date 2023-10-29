//
//  HomeViewModel.swift
//  Copilot
//
//  Created by Jamal on 10/10/23.
//

import Foundation

protocol HomeViewModelCoordinatorDelegate: AnyObject {
 func goToNearMe()
}

protocol HomeViewModelViewDelegate: AnyObject {
    
}

protocol HomeViewModelType: AnyObject {
    var delegate: HomeViewModelViewDelegate? { get set }
    func goToNearMe()
}

class HomeViewModel: HomeViewModelType {
    
    // MARK: - Delegates
    var coordinatorDelegate: HomeViewModelCoordinatorDelegate?
    weak var delegate: HomeViewModelViewDelegate?
    
    func goToNearMe(){
        coordinatorDelegate?.goToNearMe()
    }
}
