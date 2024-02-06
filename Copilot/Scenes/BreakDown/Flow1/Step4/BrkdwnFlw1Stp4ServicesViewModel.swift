//
//  BrkdwnFlw1Stp2ServicesViewModel.swift
//  Copilot
//
//  Created by Jamal on 2/6/24.
//

import Foundation

protocol BrkdwnFlw1Stp2ServicesCrdinatorDlgt: AnyObject {
    
    func getBack()
    func goToBrkdwnFlw1Stp5ServiceDetail(towTruck: Bool, service: Supplier)
}
class BrkdwnFlw1Stp2ServicesViewModel: ServicesViewModel {
    weak var breakDownCoordinatorDelegate: BrkdwnFlw1Stp2ServicesCrdinatorDlgt?
    
    override func goToServiceDetail(service: Supplier) {
        breakDownCoordinatorDelegate?.goToBrkdwnFlw1Stp5ServiceDetail(towTruck: true, service: service)
    }
}
