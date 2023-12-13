//
//  HGSViewModel.swift
//  Copilot
//
//  Created by Jamal on 11/24/23.
//

import Foundation
protocol HGSViewModelCoordinatorDelegate: AnyObject {
    func goToHGSDetail(transition: Transition)
}

protocol HGSViewModelDelegate: AnyObject {
    func showError(title: String, message: String)
    func reloadData()
}

protocol HGSViewModelType: AnyObject {
    var coordinatorDelegate: HGSViewModelCoordinatorDelegate? { get set }
    var delegate: HGSViewModelDelegate? { get set }
    var transitons: [Transition]? { get set }
    func getTransitions()
    func goToHGSDetail(transition: Transition)
}

class HGSViewModel: HGSViewModelType {
    
    var coordinatorDelegate: HGSViewModelCoordinatorDelegate?
    weak var delegate: HGSViewModelDelegate?
    var transitons: [Transition]?
    
    func goToHGSDetail(transition: Transition) {
        coordinatorDelegate?.goToHGSDetail(transition: transition)
    }
    
    func getTransitions() {
        Loading.shared.show()
        APIService.getTransitions { [weak self] model, error in
            Loading.shared.hide()
            guard let self = self else { return }
            
            if let model = model {
                self.transitons = model
                if model.count == 0 {
                    let message = App.getString(key: CodeStrings.hgsEmpty) ?? Strings.hgsEmpty
                    self.delegate?.showError(title: Strings.noHGS,
                                             message: message)
                }
                self.delegate?.reloadData()
            } else
            
            if let error = error {
                self.delegate?.showError(title: Strings.errorTitle,
                                         message: error.message)
            }
        }
    }
}
