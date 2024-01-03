//
//  ServiceDetailViewModel.swift
//  Copilot
//
//  Created by Jamal on 1/2/24.
//

import Foundation
protocol ServiceDetailVMCoordinatorDelegate: AnyObject {
    func getBack()
    func presentCalendar(delegate: CalendarViewControllerDelegate)
    func goToServiceRandevu(randevu: MockRandevu)
}

protocol ServiceDetailViewModelDelegate: BaseViewModelDelegate {
    
}

protocol ServiceDetailViewModelType: AnyObject {
    var coordinatorDelegate: ServiceDetailVMCoordinatorDelegate? { get set }
    var delegate: ServiceDetailViewModelDelegate? { get set }
    var service: Supplier? { get set }
    func getBack()
    func presentCalendar(delegate: CalendarViewControllerDelegate)
    func goToServiceRandevu(date: String, time: String)
}

class ServiceDetailViewModel: ServiceDetailViewModelType {
    weak var coordinatorDelegate: ServiceDetailVMCoordinatorDelegate?
    weak var delegate: ServiceDetailViewModelDelegate?
    
    var service: Supplier?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func presentCalendar(delegate: CalendarViewControllerDelegate) {
        coordinatorDelegate?.presentCalendar(delegate: delegate)
    }
    
    func goToServiceRandevu(date: String, time: String) {
        if let service = service {
            let model = MockRandevu(supplier: service, date: date, time: time)
            coordinatorDelegate?.goToServiceRandevu(randevu: model)
        }
    }
}
