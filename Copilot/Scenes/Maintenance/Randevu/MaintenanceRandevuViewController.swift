//
//  MaintenanceRandevuViewController.swift
//  Copilot
//
//  Created by Jamal on 1/31/24.
//

import Foundation
import UIKit

class MaintenanceRandevuViewController: ServiceRandevuViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
#if DEV_DEBUG
//        viewModel.goToConfirmedRandevu()
#endif
    }
    
    override func setTexts() {
        super.setTexts()
        desciptionLabel.text = App.getString(key: "copilotapp.servicemaintenance.service.appointment.confirmation.description")
        editButton.setTitle(App.getString(key: "copilotapp.servicemaintenance.service.appointment.confirmation.edit.button"), for: .normal)
        confirmButton.setTitle(App.getString(key: "copilotapp.servicemaintenance.service.appointment.confirmation.confirm.button"), for: .normal)
    }
    
}
