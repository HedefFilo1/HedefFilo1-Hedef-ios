//
//  SupportGuideViewModel.swift
//  Copilot
//
//  Created by Jamal on 3/20/24.
//

import Foundation

protocol SupportGuideVMCrdinatorDlgt: AnyObject {
    func getBack()
    func goToSupportGuideDetail(item: SupportGuide)
}

protocol SupportGuideViewModelDelegate: BaseViewModelDelegate {
    func reloadData()
}

protocol SupportGuideViewModelType: AnyObject {
    var coordinatorDelegate: SupportGuideVMCrdinatorDlgt? { get set }
    var delegate: SupportGuideViewModelDelegate? { get set }
    var items: [SupportGuide]? { get set }
    func getBack()
    func getGuides()
    func goToSupportGuideDetail(item: SupportGuide)
}

class SupportGuideViewModel: SupportGuideViewModelType {
    weak var coordinatorDelegate: SupportGuideVMCrdinatorDlgt?
    weak var delegate: SupportGuideViewModelDelegate?
    var items: [SupportGuide]?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
 
    func getGuides() {
        Loading.shared.show()
        APIService.getSupportGuides { [weak self] model, error in
            Loading.shared.hide()
            guard let self = self else { return }
            
            if let error = error {
                self.delegate?.showError(title: Strings.errorTitle,
                                         message: error.message)
            }
            if let model {
                self.items = model
                self.delegate?.reloadData()
            }
        }
    }
    
    func goToSupportGuideDetail(item: SupportGuide) {
        coordinatorDelegate?.goToSupportGuideDetail(item: item)
    }
}
