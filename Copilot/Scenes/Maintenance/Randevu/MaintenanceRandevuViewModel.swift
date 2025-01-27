//
//  MaintenanceRandevuViewModel.swift
//  Copilot
//
//  Created by Jamal on 1/31/24.
//

import Foundation

class MaintenanceRandevuViewModel: ServiceRandevuViewModel {
    override func createRandevu() {
        guard let service, let date else { return }
        Loading.shared.show()
        APIService.createMaintenanceCase(supplierId: service.id,
                                         supplierName: service.name,
                                         supplierPhone: service.phone ?? "",
                                         city: service.city ?? "",
                                         district: service.district ?? "",
                                         appointmentDate: date) { [weak self] _, error in
            Loading.shared.hide()
            guard let self = self else { return }
            
            if let error = error {
                self.delegate?.showError(title: Strings.errorTitle,
                                         message: error.message)
            } else {
                APIService.addUserAction(pageName: "Services", actionName: "SERVICE_MAINTENANCE_CONFIRM_MAINTENANCE_APPOINTMENT")
                APIService.addUserAction(pageName: "CASE", actionName: "CASE_UPSERT")
                self.goToConfirmedRandevu()
            }
        }
    }
}
