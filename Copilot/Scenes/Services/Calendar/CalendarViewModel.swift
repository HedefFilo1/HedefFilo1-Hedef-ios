//
//  CalendarViewModel.swift
//  Copilot
//
//  Created by Jamal on 1/2/24.
//

import Foundation

protocol CalendarVMCoordinatorDelegate: AnyObject {
    func getBack()
}

protocol CalendarViewModelDelegate: BaseViewModelDelegate {
    
}

protocol CalendarViewModelType: AnyObject {
    var coordinatorDelegate: CalendarVMCoordinatorDelegate? { get set }
    var delegate: CalendarViewModelDelegate? { get set }
    var service: Supplier? { get set }
    func getBack()
}

class CalendarViewModel: CalendarViewModelType {
    weak var coordinatorDelegate: CalendarVMCoordinatorDelegate?
    weak var delegate: CalendarViewModelDelegate?
    
    var service: Supplier?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
}
