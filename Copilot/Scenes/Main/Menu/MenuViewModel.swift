//
//  MenuViewModel.swift
//  Copilot
//
//  Created by Jamal on 10/12/23.
//

import Foundation
import UIKit

protocol MenuViewModelCoordinatorDelegate: AnyObject {
    func hideMenu()
    func showProfile()
    func showCampaigns()
    func showDocuments()
}

protocol MenuViewModelDelegate: AnyObject {
    
}

protocol MenuViewModelType: AnyObject {
    
    var coordinatorDelegate: MenuViewModelCoordinatorDelegate? { get set }
    var delegate: MenuViewModelDelegate? { get set }
    func hideMenu()
    func showProfile()
    func showCampaigns()
    func showDocuments()
}

class MenuViewModel: MenuViewModelType {
   
    weak var coordinatorDelegate: MenuViewModelCoordinatorDelegate?
    weak var delegate: MenuViewModelDelegate?
    
    func hideMenu() {
        coordinatorDelegate?.hideMenu()
    }
    
    func showProfile() {
        coordinatorDelegate?.showProfile()
    }
    
    func showCampaigns() {
        coordinatorDelegate?.showCampaigns()
    }
    
    func showDocuments() {
        coordinatorDelegate?.showDocuments()
    }
}
