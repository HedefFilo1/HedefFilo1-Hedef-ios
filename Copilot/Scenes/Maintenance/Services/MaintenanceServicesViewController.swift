//
//  MaintenanceMaintenanceServicesViewController.swift
//  Copilot
//
//  Created by Jamal on 1/31/24.
//

import Foundation
import UIKit
import CoreLocation

class MaintenanceServicesViewController: ServicesViewController {
    
//    var viewModel: MaintenanceServicesViewModelType! {
//        didSet {
//            viewModel.delegate = self
//        }
//    }
    
    override func setTexts() {
        super.setTexts()
        descriptionLabel.text = Strings.maintenanceServicesDescription
    }
}

