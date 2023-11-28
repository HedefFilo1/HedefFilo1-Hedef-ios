//
//  HGSViewModel.swift
//  Copilot
//
//  Created by Jamal on 11/24/23.
//

import Foundation
protocol HGSViewModelCoordinatorDelegate: AnyObject {
    func goToHGSDetail()
}

protocol HGSViewModelDelegate: AnyObject {
    
}

protocol HGSViewModelType: AnyObject {
    var coordinatorDelegate: HGSViewModelCoordinatorDelegate? { get set }
    var delegate: HGSViewModelDelegate? { get set }
    func goToHGSDetail()
}

class HGSViewModel: HGSViewModelType {
    
    var coordinatorDelegate: HGSViewModelCoordinatorDelegate?
    weak var delegate: HGSViewModelDelegate?
    
    func goToHGSDetail() {
        coordinatorDelegate?.goToHGSDetail()
    }
}
