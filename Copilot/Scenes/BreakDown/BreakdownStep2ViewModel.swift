//
//  BreakdownStep2ViewModel.swift
//  Copilot
//
//  Created by Jamal on 2/6/24.
//

import Foundation

protocol BreakdownStep2VMCoordinatorDelegate: AnyObject {
    func getBack()
    func getBackToHome()
    
//    func goToServiceDetail(service: Supplier?, appointment: Case?, BreakdownStep2SupportType: BreakdownStep2SupportType?)
}

protocol BreakdownStep2ViewModelDelegate: BaseViewModelDelegate {
    
}

protocol BreakdownStep2ViewModelType: AnyObject {
    var coordinatorDelegate: BreakdownStep2VMCoordinatorDelegate? { get set }
    var delegate: BreakdownStep2ViewModelDelegate? { get set }
    var appointment: Case? { get set }
    func getBack()
    func getBackToHome()
}

class BreakdownStep2ViewModel: BreakdownStep2ViewModelType {
    
    weak var coordinatorDelegate: BreakdownStep2VMCoordinatorDelegate?
    weak var delegate: BreakdownStep2ViewModelDelegate?
    var appointment: Case?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func getBackToHome() {
        coordinatorDelegate?.getBackToHome()
    }
    
}
