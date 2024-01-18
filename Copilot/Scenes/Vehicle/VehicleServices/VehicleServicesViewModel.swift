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
    func presentFilters(services: [Supplier], delegate: ServiceFilterViewControllerDelegate)
}

protocol VehicleServicesViewModelDelegate: BaseViewModelDelegate {
    func reloadData()
}

protocol VehicleServicesViewModelType: AnyObject {
    var coordinatorDelegate: VehicleServicesVMCoordinatorDelegate? { get set }
    var delegate: VehicleServicesViewModelDelegate? { get set }
    var services: [Supplier]? { get set }
    var filteredServices: [Supplier]? { get }
    var searchText: String { get set }
    var filterCity: String? { get set }
    var filterDistrict: String? { get set }
    func getServices(lat: Double?, lon: Double?)
    func presentFilters()
    func openGoogleMap(latitude: Double, longitude: Double)
    func openAppleMap(latitude: Double, longitude: Double)
}

class VehicleServicesViewModel: VehicleServicesViewModelType {
    weak var coordinatorDelegate: VehicleServicesVMCoordinatorDelegate?
    weak var delegate: VehicleServicesViewModelDelegate?
    var services: [Supplier]?
    
    var filterCity: String?
    var filterDistrict: String?
    
    var searchText: String = ""
    
    var filteredServices: [Supplier]? {
        var result = services
        if let city = filterCity {
            result = result?.filter({ $0.city == city })
        }
        
        if let district = filterDistrict {
            result = result?.filter({ $0.district == district })
        }
        
        if searchText.count == 0 {
            return result
        }
        
        let result2 = result?.filter {
            $0.name.lowercased().contains(searchText.lowercased())
        }
        
        return result2
    }
    
    func getServices(lat: Double?, lon: Double?) {
        let mark = App.vehicle?.make ?? ""
        Loading.shared.show()
        APIService.getSupplier(mark: mark, lat: lat, lon: lon) { [weak self] model, error in
            Loading.shared.hide()
            guard let self = self else { return }
            
            if let model = model {
                self.services = model
                self.delegate?.reloadData()
            } else
            
            if let error = error {
                self.delegate?.showError(title: Strings.errorTitle,
                                         message: error.message)
            }
        }
    }
    
    func presentFilters() {
        coordinatorDelegate?.presentFilters(services: services ?? [], delegate: self)
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

extension VehicleServicesViewModel: ServiceFilterViewControllerDelegate {
    func didTapApply(city: String?, district: String?) {
        filterCity = city
        filterDistrict = district
        delegate?.reloadData()
    }
}
