//
//  MenuViewModel.swift
//  Copilot
//
//  Created by Jamal on 10/12/23.
//

import Foundation
import UIKit

struct MenuItem {
    let id: Int
    let title: String?
    let image: UIImage
}

protocol MenuViewModelCoordinatorDelegate: AnyObject {
    //    func hideMenu()
    func showProfile()
    func showCampaigns()
    func showDocuments()
    func showVehicleInfo()
    func showVehicleHGS()
    func showRequests()
    func showServices()
    func showSettings()
    func presentDeleteAccount()
}

protocol MenuViewModelDelegate: AnyObject {
    
}

protocol MenuViewModelType: AnyObject {
    
    var coordinatorDelegate: MenuViewModelCoordinatorDelegate? { get set }
    var delegate: MenuViewModelDelegate? { get set }
    var visibleItems: [MenuItem] { get set }
    func hideMenu()
    func showProfile()
    func showCampaigns()
    func showDocuments()
    func showVehicleInfo()
    func showVehicleHGS()
    func showRequests()
    func showServices()
    func showSettings()
    func presentDeleteAccount()
}

class MenuViewModel: MenuViewModelType {
    
    weak var coordinatorDelegate: MenuViewModelCoordinatorDelegate?
    weak var delegate: MenuViewModelDelegate?
    
    var items = [
        MenuItem(id: 0, title: App.getString(key: "copilotapp.more.profile"),
                 image: Images.personIcon),
        
        MenuItem(id: 1, title: App.getString(key: "copilotapp.more.campaign"),
                 image: Images.percentIcon),
        
        MenuItem(id: 2, title: App.getString(key: "copilotapp.more.documents"),
                 image: Images.documentIcon),
        
        MenuItem(id: 3, title: App.getString(key: "copilotapp.more.vehicle.info"),
                 image: Images.carIcon),
        
        MenuItem(id: 4, title: App.getString(key: "copilotapp.more.vehicle.hgs.pass"),
                 image: Images.carIcon),
        
        MenuItem(id: 5, title: App.getString(key: "copilotapp.more.demands"),
                 image: Images.listIcon),
        
        MenuItem(id: 6, title: App.getString(key: "copilotapp.more.services"),
                 image: Images.toolIcon.withRenderingMode(.alwaysTemplate)),
        
        MenuItem(id: 7, title: App.getString(key: "copilotapp.more.settings"),
                 image: Images.settingsIcon),
        
        MenuItem(id: 8, title: Strings.deleteMyAccount,
                 image: Images.userDeleteIcon.withRenderingMode(.alwaysTemplate))
    ]
    
    var visibleItems: [MenuItem] = []
    
    init() {
        for item in items {
            if let title = item.title, !title.isEmpty {
                visibleItems.append(item)
            }
        }
    }
    
    func hideMenu() {
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
    
    func showVehicleInfo() {
        coordinatorDelegate?.showVehicleInfo()
    }
    
    func showVehicleHGS() {
        coordinatorDelegate?.showVehicleHGS()
    }
    
    func showRequests() {
        coordinatorDelegate?.showRequests()
    }
    
    func showServices() {
        coordinatorDelegate?.showServices()
    }
    
    func showSettings() {
        coordinatorDelegate?.showSettings()
    }
    
    func presentDeleteAccount() {
        coordinatorDelegate?.presentDeleteAccount()
    }
}
