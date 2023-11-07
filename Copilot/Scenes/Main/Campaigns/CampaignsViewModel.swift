//
//  CampaignsViewModel.swift
//  Copilot
//
//  Created by Jamal on 11/6/23.
//

import Foundation

protocol CampaignsViewModelCoordinatorDelegate: AnyObject {
    
}

protocol CampaignsViewModelDelegate: AnyObject {
    
}

protocol CampaignsViewModelType: AnyObject {
    var coordinatorDelegate: CampaignsViewModelCoordinatorDelegate? { get set }
    var delegate: CampaignsViewModelDelegate? { get set }
}

class CampaignsViewModel: CampaignsViewModelType {
    
    weak var coordinatorDelegate: CampaignsViewModelCoordinatorDelegate?
    weak var delegate: CampaignsViewModelDelegate?
    
}
