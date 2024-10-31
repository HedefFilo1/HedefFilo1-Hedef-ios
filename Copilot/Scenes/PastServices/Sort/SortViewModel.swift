//
//  PastServicesSortViewModel.swift
//  Copilot
//
//  Created by Jamal on 4/1/24.
//

import Foundation
protocol SortVMCoordinatorDelegate: AnyObject {
    
}

protocol SortViewModelDelegate: AnyObject {
    
}

protocol SortViewModelType: AnyObject {
    var coordinatorDelegate: SortVMCoordinatorDelegate? { get set }
    var delegate: SortViewModelDelegate? { get set }
}

class SortViewModel: SortViewModelType {
    
    weak var coordinatorDelegate: SortVMCoordinatorDelegate?
    weak var delegate: SortViewModelDelegate?
   
}
