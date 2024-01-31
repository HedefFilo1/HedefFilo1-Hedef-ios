//
//  MaintenanceServiceDetailViewControlle.swift
//  Copilot
//
//  Created by Jamal on 1/31/24.
//

import Foundation
import UIKit

class MaintenanceServiceDetailViewController: ServiceDetailViewController {
    
    override func setService() {
        super.setService()
        desciptionLabel.text = Strings.maintenanceSelectTime
    }
}
