//
//  LiveSupportViewModel.swift
//  Copilot
//
//  Created by Jamal on 3/22/24.
//

import Foundation

protocol LiveSupportViewModelCoordinatorDelegate: AnyObject {
    func getBack()
    
}

protocol LiveSupportViewModelDelegate: BaseViewModelDelegate {
    func loadWebView()
}

protocol LiveSupportViewModelType: AnyObject {
    var delegate: LiveSupportViewModelDelegate? { get set }
    var coordinatorDelegate: LiveSupportViewModelCoordinatorDelegate? { get set }
    var model: LiveSupport? { get set }
    func getBack()
    func getLiveSupport()
}

class LiveSupportViewModel: LiveSupportViewModelType {
    
    // MARK: - Delegates
    weak var coordinatorDelegate: LiveSupportViewModelCoordinatorDelegate?
    weak var delegate: LiveSupportViewModelDelegate?
    var model: LiveSupport?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func getLiveSupport() {
        Loading.shared.show()
        APIService.getLiveSupport { [weak self] model, error in
            Loading.shared.hide()
            guard let self = self else { return }
            
            if let error = error {
                self.delegate?.showError(title: Strings.errorTitle,
                                         message: error.message)
            }
            if let model {
                self.model = model
                delegate?.loadWebView()
            }
        }
    }
}
