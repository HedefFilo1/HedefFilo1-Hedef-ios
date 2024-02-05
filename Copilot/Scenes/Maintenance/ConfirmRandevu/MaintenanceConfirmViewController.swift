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
        titleLabel.text = Strings.miantenanceRandevuSuccessMessage
        editButton.setTitle(Strings.edit, for: .normal)
        homeButton.setTitle(Strings.returnToHomePage, for: .normal)
    }
}