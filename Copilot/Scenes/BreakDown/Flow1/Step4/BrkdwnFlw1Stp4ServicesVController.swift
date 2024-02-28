//
//  BrkdwnFlw1Stp2ServicesVController.swift
//  Copilot
//
//  Created by Jamal on 2/6/24.
//

import Foundation
import UIKit
import CoreLocation

class BrkdwnFlw1Stp4ServicesVController: ServicesViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
#if DEV_DEBUG
//        viewModel.goToServiceDetail(service: Supplier(id: "df", name: "name", address: "address", lon: nil, lat: nil, district: "", city: "", phone: "092233533534"))
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
//            self.viewModel.goToServiceDetail(service: Supplier(id: "df", name: "name", address: "address", lon: nil, lat: nil, district: "", city: "", phone: "092233533534"))
//        }
        
        #endif

    }
    
    override func setTexts() {
        super.setTexts()
        descriptionLabel.text = Strings.breakdownServicesDescription
    }
}
