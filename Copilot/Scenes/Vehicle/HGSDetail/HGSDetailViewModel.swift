//
//  HGSDetailViewModel.swift
//  Copilot
//
//  Created by Jamal on 11/28/23.
//

import Foundation
protocol HGSDetailViewModelCoordinatorDelegate: AnyObject {
    func getBack()
}

protocol HGSDetailViewModelDelegate: AnyObject {
    
}

protocol HGSDetailViewModelType: AnyObject {
    var coordinatorDelegate: HGSDetailViewModelCoordinatorDelegate? { get set }
    var delegate: HGSDetailViewModelDelegate? { get set }
    func getBack()
}

class HGSDetailViewModel: HGSDetailViewModelType {
    
    weak var coordinatorDelegate: HGSDetailViewModelCoordinatorDelegate?
    weak var delegate: HGSDetailViewModelDelegate?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
}
