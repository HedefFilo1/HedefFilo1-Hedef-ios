//
//  MaintenanceServicesViewController.swift
//  Copilot
//
//  Created by Jamal on 1/31/24.
//

import Foundation
import CoreLocation
import UIKit
import MapKit

protocol MaintenanceServicesVMCoordinatorDelegate: ServicesVMCoordinatorDelegate {
    
}

protocol MaintenanceServicesViewModelDelegate: ServicesViewModelDelegate {
    
}

protocol MaintenanceServicesViewModelType: ServicesViewModelType {
//    var coordinatorDelegate: MaintenanceServicesVMCoordinatorDelegate? { get set }
//    var delegate: MaintenanceServicesViewModelDelegate? { get set }
}

class MaintenanceServicesViewModel: ServicesViewModel {
//    weak var coordinatorDelegate: MaintenanceServicesVMCoordinatorDelegate?
//    weak var delegate: MaintenanceServicesViewModelDelegate?
    
//    func goToServiceDetail(service: Supplier) {
//        coordinatorDelegate?.goToServiceDetail(service: service, appointment: nil, tireSupportType: tireSupportType)
//    }
}
