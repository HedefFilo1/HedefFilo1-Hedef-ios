//
//  AccidentServicesViewModel.swift
//  Copilot
//
//  Created by Jamal on 2/17/24.
//

import Foundation

enum AccidentReportType: String {
    case anlasmalITutanak = "ANLASMALI_TUTANAK"
    case zabit = "ZABIT"
    case beyan = "BEYAN"
}

protocol AccidentServicesCrdinatorDlgt: AnyObject {
    
    func getBack()
    func goToServiceDetail(towTruck: Bool, service: Supplier)
}

class AccidentServicesViewModel: ServicesViewModel {
    weak var accidentCoordinatorDelegate: AccidentServicesCrdinatorDlgt?
    
    override func goToServiceDetail(service: Supplier) {
        accidentCoordinatorDelegate?.goToServiceDetail(towTruck: towTruck, service: service)
    }
}
