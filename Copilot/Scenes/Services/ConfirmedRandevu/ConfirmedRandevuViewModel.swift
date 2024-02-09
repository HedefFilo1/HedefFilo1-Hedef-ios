//
//  ConfirmedRandevuViewModel.swift
//  Copilot
//
//  Created by Jamal on 1/3/24.
//

import Foundation

protocol ConfirmedRandevuVMCoordinatorDelegate: AnyObject {
    func getBack()
    func getBackToHome()
}

protocol ConfirmedRandevuViewModelDelegate: BaseViewModelDelegate {
    
}

protocol ConfirmedRandevuViewModelType: AnyObject {
    var coordinatorDelegate: ConfirmedRandevuVMCoordinatorDelegate? { get set }
    var delegate: ConfirmedRandevuViewModelDelegate? { get set }
    var service: Supplier? { get set }
    var date: Date? { get set }
    var appointment: Case? { get set }
    var displayDate: String? { get }
    func getBack()
    func getBackToHome()
}

class ConfirmedRandevuViewModel: ConfirmedRandevuViewModelType {
    weak var coordinatorDelegate: ConfirmedRandevuVMCoordinatorDelegate?
    weak var delegate: ConfirmedRandevuViewModelDelegate?
    
    var service: Supplier?
    var date: Date?
    var appointment: Case?
    
    var displayDate: String? {
        guard let date = date else { return nil }
        let formmater = DateFormatter()
        formmater.dateFormat = "d MMMM YYYY EEEE HH:mm"
        formmater.locale = Locale(identifier: "tr_TR")
        return formmater.string(from: date)
    }
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func getBackToHome() {
        coordinatorDelegate?.getBackToHome()
    }
    
}
