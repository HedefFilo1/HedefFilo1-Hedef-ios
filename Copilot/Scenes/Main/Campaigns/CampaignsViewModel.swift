//
//  CampaignsViewModel.swift
//  Copilot
//
//  Created by Jamal on 11/6/23.
//

import Foundation

protocol CampaignsViewModelCoordinatorDelegate: AnyObject {
    func goToCampaignDetail()
}

protocol CampaignsViewModelDelegate: AnyObject {
    
}

protocol CampaignsViewModelType: AnyObject {
    var coordinatorDelegate: CampaignsViewModelCoordinatorDelegate? { get set }
    var delegate: CampaignsViewModelDelegate? { get set }
    func goToCampaignDetail()
}

class CampaignsViewModel: CampaignsViewModelType {
    
    var coordinatorDelegate: CampaignsViewModelCoordinatorDelegate?
    weak var delegate: CampaignsViewModelDelegate?
    
    func goToCampaignDetail() {
        coordinatorDelegate?.goToCampaignDetail()
    }
}
