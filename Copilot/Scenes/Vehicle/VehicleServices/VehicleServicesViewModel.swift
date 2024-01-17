//
//  ServicesViewModel.swift
//  Copilot
//
//  Created by Jamal on 12/19/23.
//

import Foundation
import UIKit
import MapKit

protocol VehicleServicesVMCoordinatorDelegate: AnyObject {
    func presentFilters()
}

protocol VehicleServicesViewModelDelegate: BaseViewModelDelegate {
    func reloadData()
}

protocol VehicleServicesViewModelType: AnyObject {
    var coordinatorDelegate: VehicleServicesVMCoordinatorDelegate? { get set }
    var delegate: VehicleServicesViewModelDelegate? { get set }
    var services: [Supplier]? { get set }
    var filteredServices: [Supplier]? { get set }
    var searchText: String { get set }
    func getServices(lat: Double?, lon: Double?)
    func presentFilters()
    func openGoogleMap(latitude: Double, longitude: Double)
    func openAppleMap(latitude: Double, longitude: Double)
}

class VehicleServicesViewModel: VehicleServicesViewModelType {
    weak var coordinatorDelegate: VehicleServicesVMCoordinatorDelegate?
    weak var delegate: VehicleServicesViewModelDelegate?
    var services: [Supplier]?
    
    var searchText: String = "" {
        didSet {
            if searchText.count == 0 {
                filteredServices = services
                return
            }
            
            let result = services?.filter {
                $0.name.lowercased().contains(searchText.lowercased())
            }
            
            filteredServices = result
        }
    }
    
    var filteredServices: [Supplier]?
    
    func getServices(lat: Double?, lon: Double?) {
        let mark = App.vehicle?.make ?? ""
        Loading.shared.show()
        APIService.getSupplier(mark: mark, lat: lat, lon: lon) { [weak self] model, error in
            Loading.shared.hide()
            guard let self = self else { return }
            
            if let model = model {
                self.services = model
                self.filteredServices = model
                self.delegate?.reloadData()
            } else
            
            if let error = error {
                self.delegate?.showError(title: Strings.errorTitle,
                                         message: error.message)
            }
        }
    }
    
    func presentFilters() {
        coordinatorDelegate?.presentFilters()
    }
    
    func openGoogleMap(latitude: Double, longitude: Double) {
        if let urlDestination = URL.init(string: "https://maps.google.com/?q=@\(latitude),\(longitude)") {
            UIApplication.shared.open(urlDestination)
        }
    }
    
    func openAppleMap(latitude: Double, longitude: Double) {
        let coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary: nil))
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
    }
}
