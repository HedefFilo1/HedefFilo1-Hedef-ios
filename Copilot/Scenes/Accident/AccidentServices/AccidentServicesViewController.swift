//
//  AccidentServicesViewController.swift
//  Copilot
//
//  Created by Jamal on 2/17/24.
//

import Foundation
import UIKit
import CoreLocation

class AccidentServicesViewController: ServicesViewController {
    
    //    var viewModel: AccidentServicesViewModelType! {
    //        didSet {
    //            viewModel.delegate = self
    //        }
    //    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
#if DEV_DEBUG
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.viewModel.goToServiceDetail(service: Supplier(id: "df", name: "name", address: "address", lon: nil, lat: nil, district: "", city: "", phone: "092233533534"))
        }
        
        #endif
    }
    
    override func setTexts() {
        super.setTexts()
        titleLabel.text = Strings.accidentOperations
        descriptionLabel.text = Strings.accidentServicesDescription
    }
}
