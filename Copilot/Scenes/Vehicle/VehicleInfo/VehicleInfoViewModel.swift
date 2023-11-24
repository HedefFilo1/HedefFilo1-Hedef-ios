//
//  VehicleInfoViewModel.swift
//  Copilot
//
//  Created by Jamal on 11/23/23.
//

import Foundation

protocol VehicleInfoViewModelCoordinatorDelegate: AnyObject {
    func goToDocument()
    func goToVehicleGuide()
    
}

protocol VehicleInfoViewModelDelegate: AnyObject {
    func reloadData()
}

protocol VehicleInfoViewModelType: AnyObject {
    var coordinatorDelegate: VehicleInfoViewModelCoordinatorDelegate? { get set }
    var delegate: VehicleInfoViewModelDelegate? { get set }
    var documents: [Document]? { get set }
    func goToDocument()
    func goToVehicleGuide()
}

class VehicleInfoViewModel: VehicleInfoViewModelType {
    
    var coordinatorDelegate: VehicleInfoViewModelCoordinatorDelegate?
    weak var delegate: VehicleInfoViewModelDelegate?
    
    var documents: [Document]? = [
        Document(id: 0, title: "Özet Araç Sözleşmesi", date: ""),
        Document(id: 2, title: "Araç Sözleşmesi", date: ""),
        Document(id: 3, title: "Sigorta Belgesi", date: ""),
        Document(id: 4, title: "Kasko Belgesi", date: "")
    ]
    
    func goToDocument() {
        coordinatorDelegate?.goToDocument()
    }
    
    func goToVehicleGuide() {
        coordinatorDelegate?.goToVehicleGuide()
    }
}
