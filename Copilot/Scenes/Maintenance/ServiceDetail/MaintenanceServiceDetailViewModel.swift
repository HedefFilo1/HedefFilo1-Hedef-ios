//
//  MaintenanceServiceDetailViewModel.swift
//  Copilot
//
//  Created by Jamal on 2/1/24.
//

import Foundation

class MaintenanceServiceDetailViewModel: ServiceDetailViewModel {
   
    override func goToServiceRandevu(date: Date, hour: String, minute: String) {
        guard let hour = Int(hour), let min = Int(minute) else { return }
        if let service = service,
           let date = date.setTime(hour: hour, min: min) {
            coordinatorDelegate?.goToServiceRandevu(service: service, date: date, tireSupportType: nil)
        }
    }
}
