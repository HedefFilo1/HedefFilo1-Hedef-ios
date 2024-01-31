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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.goToServiceDetail(service: Supplier(id: "", name: "name of sr", address: "addres", lon: nil, lat: nil, district: "sud", city: "cit", phone: "87347039"))
    }
    
    override func setTexts() {
        super.setTexts()
        descriptionLabel.text = Strings.maintenanceServicesDescription
    }
}
