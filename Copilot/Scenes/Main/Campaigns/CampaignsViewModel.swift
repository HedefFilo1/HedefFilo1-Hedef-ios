//
//  CampaignsViewModel.swift
//  Copilot
//
//  Created by Jamal on 11/6/23.
//

import Foundation

protocol CampaignsViewModelCoordinatorDelegate: AnyObject {
    func goToCampaignDetail(campaign: Campaign)
}

protocol CampaignsViewModelDelegate: AnyObject {
    func reloadData()
    func showError(title: String, message: String)
}

protocol CampaignsViewModelType: AnyObject {
    var coordinatorDelegate: CampaignsViewModelCoordinatorDelegate? { get set }
    var delegate: CampaignsViewModelDelegate? { get set }
    var allCampgins: [Campaign]? { get set }
    func getCampaign()
    func goToCampaignDetail(campaign: Campaign)
}

class CampaignsViewModel: CampaignsViewModelType {
    
    var coordinatorDelegate: CampaignsViewModelCoordinatorDelegate?
    weak var delegate: CampaignsViewModelDelegate?
    var allCampgins: [Campaign]?
    
    var campaigns: [Campaign]? {
        return allCampgins?.filter({ $0.campaignType == .campaign})
    }
    
    var sponserships: [Campaign]? {
        return allCampgins?.filter({ $0.campaignType == .sponsership})
    }
    
    var news: [Campaign]? {
        return allCampgins?.filter({ $0.campaignType == .news})
    }
    
    func getCampaign() {
        Loading.shared.show()
        APIService.getCampaigns { [weak self] model, error in
            Loading.shared.hide()
            guard let self = self else { return }
            
            if let model = model {
                self.allCampgins = model
                self.delegate?.reloadData()
            } else if let error = error {
                self.delegate?.showError(title: Strings.errorTitle,
                                         message: error.message)
            }
        }
    }
    
    func goToCampaignDetail(campaign: Campaign) {
        coordinatorDelegate?.goToCampaignDetail(campaign: campaign)
    }
}
