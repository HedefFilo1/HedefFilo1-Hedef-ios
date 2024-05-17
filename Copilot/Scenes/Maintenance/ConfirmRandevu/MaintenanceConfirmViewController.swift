//
//  MaintenanceConfirmViewController.swift
//  Copilot
//
//  Created by Jamal on 1/31/24.
//

import Foundation

class MaintenanceConfirmViewController: ConfirmedRandevuViewController {
    override func setTexts() {
        super.setTexts()
        titleLabel.text = App.getString(key: "copilotapp.servicemaintenance.service.appointment.confirmation.success.title")
        editButton.setTitle(App.getString(key: "copilotapp.servicemaintenance.maintenance.appointment.request.edit"), for: .normal)
        homeButton.setTitle(App.getString(key: "copilotapp.servicemaintenance.maintenance.operation.schedule.maintenance.appointment.negative.result.button"), for: .normal)
    }
}
