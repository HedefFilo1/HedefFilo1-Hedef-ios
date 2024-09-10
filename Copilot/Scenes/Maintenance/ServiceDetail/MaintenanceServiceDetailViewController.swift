//
//  MaintenanceServiceDetailViewControlle.swift
//  Copilot
//
//  Created by Jamal on 1/31/24.
//

import Foundation
import UIKit

class MaintenanceServiceDetailViewController: ServiceDetailViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
#if DEV_DEBUG
//        viewModel.goToServiceRandevu(date: Date(), hour: "14", minute: "45")
    #endif
    }
    
    override func setService() {
        super.setService()
//        desciptionLabel.text = App.getString(key: "copilotapp.servicemaintenance.service.detail.description")
        desciptionLabel.text = App.getString(key: "copilotapp.servicemaintenance.service.detail.description")
//        desciptionLabel.text = App.getString(key: "copilotapp.servicemaintenance.select.appointment.hour.detail")
        selectTimeLabel.text = App.getString(key: "copilotapp.servicemaintenance.service.detail.select.hour")
    }
    
    override func setAppointment() {
//        guard let item = viewModel.appointment else { return }
        super.setAppointment()
//        desciptionLabel.text = Strings.maintenanceEditAppointment
        
    }
}
