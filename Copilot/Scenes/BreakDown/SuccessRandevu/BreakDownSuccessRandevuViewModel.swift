//
//  BreakDownSuccessRandevuViewModel.swift
//  Copilot
//
//  Created by Jamal on 2/7/24.
//

import Foundation
protocol BreakDownSuccessRandevuVMCrdinatorDlgt: AnyObject {
    func getBack()
    func getBackToHome()
}

protocol BreakDownSuccessRandevuViewModelDelegate: BaseViewModelDelegate {
    
}

protocol BreakDownSuccessRandevuViewModelType: AnyObject {
    var coordinatorDelegate: BreakDownSuccessRandevuVMCrdinatorDlgt? { get set }
    var delegate: BreakDownSuccessRandevuViewModelDelegate? { get set }
    var service: Supplier? { get set }
    var appointment: Case? { get set }
    var date: Date? { get set }
    var displayDate: String? { get }
    func getBack()
    func getBackToHome()
}

class BreakDownSuccessRandevuViewModel: BreakDownSuccessRandevuViewModelType {
    weak var coordinatorDelegate: BreakDownSuccessRandevuVMCrdinatorDlgt?
    weak var delegate: BreakDownSuccessRandevuViewModelDelegate?
    
    var service: Supplier?
    var appointment: Case?
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
