//
//  AccidentSuccessRandevuViewModel.swift
//  Copilot
//
//  Created by Jamal on 2/17/24.
//

import Foundation

protocol AccidentSuccessRandevuVMCrdinatorDlgt: AnyObject {
    func getBack()
    func getBackToHome()
}

protocol AccidentSuccessRandevuViewModelDelegate: BaseViewModelDelegate {
    
}

protocol AccidentSuccessRandevuViewModelType: AnyObject {
    var coordinatorDelegate: AccidentSuccessRandevuVMCrdinatorDlgt? { get set }
    var delegate: AccidentSuccessRandevuViewModelDelegate? { get set }
    var service: Supplier? { get set }
    var date: Date? { get set }
    var displayDate: String? { get }
    func getBack()
    func getBackToHome()
}

class AccidentSuccessRandevuViewModel: AccidentSuccessRandevuViewModelType {
    weak var coordinatorDelegate: AccidentSuccessRandevuVMCrdinatorDlgt?
    weak var delegate: AccidentSuccessRandevuViewModelDelegate?
    
    var service: Supplier?
    var date: Date?
    
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
