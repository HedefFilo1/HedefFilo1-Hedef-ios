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
    var tireSupportType: TireSupportType? { get set }
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
    var tireSupportType: TireSupportType? = .damage
    
    var displayDate: String? {
        guard let date = date else { return nil }
        let formmater = DateFormatter()
        formmater.dateFormat = "d MMMM YYYY EEEE HH:mm"
        var identifier = "tr_TR"
        let language = App.language
        if language == CodeStrings.english {
            identifier = "UTC"
        }
        formmater.locale = Locale(identifier: identifier)
        return formmater.string(from: date)
    }
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func getBackToHome() {
        coordinatorDelegate?.getBackToHome()
    }
    
}
