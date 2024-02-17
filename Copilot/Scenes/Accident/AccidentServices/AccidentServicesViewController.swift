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
//        viewModel.goToServiceDetail(service: Supplier(id: "", name: "name of sr", address: "addres", lon: nil, lat: nil, district: "sud", city: "cit", phone: "87347039"))
    }
    
    override func setTexts() {
        super.setTexts()
        titleLabel.text = Strings.accidentOperations
        descriptionLabel.text = Strings.accidentServicesDescription
    }
}
