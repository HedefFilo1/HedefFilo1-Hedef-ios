//
//  ServiceDetailViewModel.swift
//  Copilot
//
//  Created by Jamal on 1/2/24.
//

import Foundation
import UIKit
import CoreLocation
import MapKit

protocol ServiceDetailVMCoordinatorDelegate: AnyObject {
    func getBack()
    func presentCalendar(delegate: CalendarViewControllerDelegate)
    func goToServiceRandevu(randevu: MockRandevu)
}

protocol ServiceDetailViewModelDelegate: BaseViewModelDelegate {
    
}

protocol ServiceDetailViewModelType: AnyObject {
    var coordinatorDelegate: ServiceDetailVMCoordinatorDelegate? { get set }
    var delegate: ServiceDetailViewModelDelegate? { get set }
    var service: Supplier? { get set }
    var randevu: String? { get set }
    func getBack()
    func presentCalendar(delegate: CalendarViewControllerDelegate)
    func goToServiceRandevu(date: String, time: String)
    func openGoogleMap(latitude: Double, longitude: Double)
    func openAppleMap(latitude: Double, longitude: Double)
}

class ServiceDetailViewModel: ServiceDetailViewModelType {
    weak var coordinatorDelegate: ServiceDetailVMCoordinatorDelegate?
    weak var delegate: ServiceDetailViewModelDelegate?
    
    var service: Supplier?
    var randevu: String?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func presentCalendar(delegate: CalendarViewControllerDelegate) {
        coordinatorDelegate?.presentCalendar(delegate: delegate)
    }
    
    func goToServiceRandevu(date: String, time: String) {
        if let service = service {
            let model = MockRandevu(supplier: service, date: date, time: time)
            coordinatorDelegate?.goToServiceRandevu(randevu: model)
        }
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
