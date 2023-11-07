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
    
}

protocol CampaignDetailViewModelType: AnyObject {
    var coordinatorDelegate: CampaignDetailVMCoordinatorDelegate? { get set }
    var delegate: CampaignDetailViewModelDelegate? { get set }
    func getBack()
}

class CampaignDetailViewModel: CampaignDetailViewModelType {
    
    weak var coordinatorDelegate: CampaignDetailVMCoordinatorDelegate?
    weak var delegate: CampaignDetailViewModelDelegate?
    func getBack() {
        coordinatorDelegate?.getBack()
    }
}
