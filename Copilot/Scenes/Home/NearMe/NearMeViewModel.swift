//
//  NearMeViewModel.swift
//  Copilot
//
//  Created by Jamal on 10/29/23.
//

import Foundation
import MapKit

protocol NearMeViewModelCoordinatorDelegate: AnyObject {
    func getBack()
    func presentFilters(delegate: FiltersViewControllerDelegate)
}

protocol NearMeViewModelDelegate: AnyObject {
    func showError(title: String, message: String)
    func showSuppliersOnMap()
}

protocol NearMeViewModelType: AnyObject {
    var delegate: NearMeViewModelDelegate? { get set }
    var mark: String { get set }
    var suppliers: [Supplier]? { get set }
    var userLocation: CLLocation { get set }
    func getSuppliers()
    func getPlaces()
    func openGoogleMap(latitude: Double, longitude: Double)
    func openAppleMap(latitude: Double, longitude: Double)
    func getBack()
    func presentFilters()
}

class NearMeViewModel: NearMeViewModelType {
    
    // MARK: - Delegates
    weak var coordinatorDelegate: NearMeViewModelCoordinatorDelegate?
    weak var delegate: NearMeViewModelDelegate?
    var mark: String = ""
    var suppliers: [Supplier]?
    var userLocation: CLLocation = CLLocation()
    
    func getSuppliers() {
        Loading.shared.show()
        APIService.getSupplier(mark: mark) { [weak self] model, error in
            Loading.shared.hide()
            guard let self = self else { return }
            APIService.addUserAction(pageName: "HOMEPAGE", actionName: "HOMEPAGE_NEAR")
            if let model = model {
                self.suppliers = model.filter({
                    return $0.lon != nil && $0.lat != nil
                })
                self.delegate?.showSuppliersOnMap()
            } else
            
            if let error = error {
                self.delegate?.showError(title: Strings.errorTitle,
                                         message: error.message)
            }
        }
    }
    
    func getPlaces() {
//        let searchedTypes = ["bakery", "bar", "cafe", "grocery_or_supermarket", "restaurant"]
//        let searchedTypes = ["bakery"]
//        Loading.shared.show()
//        APIService.getPlaces(lat: userLocation.coordinate.latitude,
//                             lon: userLocation.coordinate.latitude,
//                             types: searchedTypes) { [weak self] model, error in
//            Loading.shared.hide()
//            guard let self = self else { return }
//            
//            if let model = model {
//                print(model)
//            } else
//            
//            if let error = error {
//                self.delegate?.showError(title: "can't load google",
//                                         message: error.message)
//            }
//        }
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
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func presentFilters() {
        coordinatorDelegate?.presentFilters(delegate: self)
    }
}

extension NearMeViewModel: FiltersViewControllerDelegate {
    func didApply(filters: [Filter]) {
        guard filters.count > 0 else { return }
        if filters.filter({ $0.id == 111 }).count == 1 {
            getSuppliers()
        }
    }
}
