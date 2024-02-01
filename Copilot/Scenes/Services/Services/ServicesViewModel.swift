//
//  ServicesViewModel.swift
//  Copilot
//
//  Created by Jamal on 12/26/23.
//

import Foundation
import CoreLocation
import UIKit
import MapKit

protocol ServicesVMCoordinatorDelegate: AnyObject {
    func presentFilters(services: [Supplier], delegate: ServiceFilterViewControllerDelegate)
    func getBack()
    func goToServiceDetail(service: Supplier?, appointment: Case?, tireSupportType: TireSupportType?, towTruck: Bool)
}

protocol ServicesViewModelDelegate: BaseViewModelDelegate {
    func reloadData()
}

protocol ServicesViewModelType: AnyObject {
    var coordinatorDelegate: ServicesVMCoordinatorDelegate? { get set }
    var delegate: ServicesViewModelDelegate? { get set }
    var services: [Supplier]? { get set }
    var tireSupportType: TireSupportType { get set}
    var filteredServices: [Supplier]? { get }
    var filterCity: String? { get set }
    var filterDistrict: String? { get set }
    var searchText: String { get set }
    var towTruck: Bool { get set }
    func getServices(lat: Double?, lon: Double?)
    func presentFilters()
    func getBack()
    func goToServiceDetail(service: Supplier)
    func openGoogleMap(latitude: Double, longitude: Double)
    func openAppleMap(latitude: Double, longitude: Double)
}

class ServicesViewModel: ServicesViewModelType {
    weak var coordinatorDelegate: ServicesVMCoordinatorDelegate?
    weak var delegate: ServicesViewModelDelegate?
    var services: [Supplier]?
    var tireSupportType: TireSupportType = .change
    
    var filterCity: String?
    var filterDistrict: String?
    
    var searchText: String = ""
    var towTruck: Bool = false
    
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
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func goToServiceDetail(service: Supplier) {
        coordinatorDelegate?.goToServiceDetail(service: service, appointment: nil, tireSupportType: tireSupportType, towTruck: towTruck)
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

extension ServicesViewModel: ServiceFilterViewControllerDelegate {
    func didTapApply(city: String?, district: String?) {
        filterCity = city
        filterDistrict = district
        delegate?.reloadData()
    }
}
