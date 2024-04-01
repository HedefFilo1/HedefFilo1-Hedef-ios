//
//  PastServicesSortViewModel.swift
//  Copilot
//
//  Created by Jamal on 4/1/24.
//

import Foundation
protocol PastServicesSortVMCoordinatorDelegate: AnyObject {
    
}

protocol PastServicesSortViewModelDelegate: AnyObject {
    
}

protocol PastServicesSortViewModelType: AnyObject {
    var coordinatorDelegate: PastServicesSortVMCoordinatorDelegate? { get set }
    var delegate: PastServicesSortViewModelDelegate? { get set }
}

class PastServicesSortViewModel: PastServicesSortViewModelType {
    
    weak var coordinatorDelegate: PastServicesSortVMCoordinatorDelegate?
    weak var delegate: PastServicesSortViewModelDelegate?
   
}
