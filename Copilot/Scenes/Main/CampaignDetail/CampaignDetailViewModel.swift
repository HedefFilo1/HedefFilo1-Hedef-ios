//
//  CampaignDetailViewModel.swift
//  Copilot
//
//  Created by Jamal on 11/7/23.
//

import Foundation

protocol CampaignDetailVMCoordinatorDelegate: AnyObject {
    func getBack()
}

protocol CampaignDetailViewModelDelegate: AnyObject {
    func showError(title: String, message: String)
    func setCampaign()
}

protocol CampaignDetailViewModelType: AnyObject {
    var coordinatorDelegate: CampaignDetailVMCoordinatorDelegate? { get set }
    var delegate: CampaignDetailViewModelDelegate? { get set }
    var campaign: Campaign? { get set }
    func selectCampaign()
    func getBack()
}

class CampaignDetailViewModel: CampaignDetailViewModelType {
    
    weak var coordinatorDelegate: CampaignDetailVMCoordinatorDelegate?
    weak var delegate: CampaignDetailViewModelDelegate?
    var campaign: Campaign?
    
    func selectCampaign() {
        guard let id = campaign?.id else { return }
        Loading.shared.show()
        APIService.getCampaignDetail(id: id) { [weak self] _, error in
            Loading.shared.hide()
            guard let self = self else { return }
            if let error = error {
                self.delegate?.showError(title: Strings.errorTitle,
                                         message: error.message)
                return
            }
            self.getBack()
        }
    }
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
}
