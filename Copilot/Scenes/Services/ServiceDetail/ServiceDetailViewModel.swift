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
    func goToServiceRandevu(service: Supplier, date: Date, tireSupportType: TireSupportType?, towTruck: Bool)
}

protocol ServiceDetailViewModelDelegate: BaseViewModelDelegate {
    
}

protocol ServiceDetailViewModelType: AnyObject {
    var coordinatorDelegate: ServiceDetailVMCoordinatorDelegate? { get set }
    var delegate: ServiceDetailViewModelDelegate? { get set }
    var appointment: Case? { get set }
    var service: Supplier? { get set }
    var tireSupportType: TireSupportType? { get set }
    var towTruck: Bool { get set }
    func getBack()
    func presentCalendar(delegate: CalendarViewControllerDelegate)
    func goToServiceRandevu(date: Date, hour: String, minute: String)
    func openGoogleMap(latitude: Double, longitude: Double)
    func openAppleMap(latitude: Double, longitude: Double)
}

class ServiceDetailViewModel: ServiceDetailViewModelType {
    weak var coordinatorDelegate: ServiceDetailVMCoordinatorDelegate?
    weak var delegate: ServiceDetailViewModelDelegate?
    
    var appointment: Case?
    var service: Supplier?
    var tireSupportType: TireSupportType?
    var towTruck: Bool = false
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func presentCalendar(delegate: CalendarViewControllerDelegate) {
        coordinatorDelegate?.presentCalendar(delegate: delegate)
    }
    
    func goToServiceRandevu(date: Date, hour: String, minute: String) {
        guard let hour = Int(hour), let min = Int(minute) else { return }
        if let service = service,
           let date = date.setTime(hour: hour, min: min),
        let type = tireSupportType {
            coordinatorDelegate?.goToServiceRandevu(service: service, date: date, tireSupportType: type, towTruck: towTruck)
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
