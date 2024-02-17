//
//  AccidentServiceDetailViewModel.swift
//  Copilot
//
//  Created by Jamal on 2/17/24.
//

import Foundation
import CoreLocation
import MapKit

protocol AccidentServiceDetailVMCrdintrDlgt: AnyObject {
    func getBack()
    func goToAccidentSuccessRandevu(service: Supplier, date: Date?)
    func presentCalendar(delegate: CalendarViewControllerDelegate)
}

protocol AccidentServiceDetailVMdlDlgt: BaseViewModelDelegate {
    
}

protocol AccidentServiceDetailViewModelType: AnyObject {
    var coordinatorDelegate: AccidentServiceDetailVMCrdintrDlgt? { get set }
    var delegate: AccidentServiceDetailVMdlDlgt? { get set }
    var towTruck: Bool { get set }
    var service: Supplier? { get set }
    func getBack()
    func createTowTruckRandevu()
    func createRandevu(with date: Date, hour: String, minute: String)
    func openGoogleMap(latitude: Double, longitude: Double)
    func openAppleMap(latitude: Double, longitude: Double)
    func presentCalendar(delegate: CalendarViewControllerDelegate)
}

class AccidentServiceDetailViewModel: AccidentServiceDetailViewModelType {
    weak var coordinatorDelegate: AccidentServiceDetailVMCrdintrDlgt?
    weak var delegate: AccidentServiceDetailVMdlDlgt?
    
    var towTruck: Bool = false
    var service: Supplier?
    
    func getBack() {
        coordinatorDelegate?.getBack()
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
    
    func createTowTruckRandevu() {
#if DEV_DEBUG
                if true {
                    self.coordinatorDelegate?.goToAccidentSuccessRandevu(service: service!, date: nil)
                    return
                }
#endif
        guard let service else { return }
        Loading.shared.show()
        APIService.createBreakDownCase(supplierId: service.id,
                                       supplierName: service.name,
                                       supplierPhone: service.phone ?? "",
                                       city: service.city ?? "",
                                       district: service.district ?? "",
                                       towTruck: true,
                                       appointmentDate: nil) { [weak self] _, error in
            Loading.shared.hide()
            guard let self = self else { return }
            
            if let error = error {
                self.delegate?.showError(title: Strings.errorTitle,
                                         message: error.message)
            } else {
                self.coordinatorDelegate?.goToAccidentSuccessRandevu(service: service, date: nil)
            }
        }
    }
    
    func createRandevu(with date: Date, hour: String, minute: String) {
        guard let hour = Int(hour), let min = Int(minute),
              let date = date.setTime(hour: hour, min: min),
              let service else { return }
        Loading.shared.show()
        APIService.createBreakDownCase(supplierId: service.id,
                                       supplierName: service.name,
                                       supplierPhone: service.phone ?? "",
                                       city: service.city ?? "",
                                       district: service.district ?? "",
                                       towTruck: false,
                                       appointmentDate: date) { [weak self] _, error in
            Loading.shared.hide()
            guard let self = self else { return }
            
            if let error = error {
                self.delegate?.showError(title: Strings.errorTitle,
                                         message: error.message)
            } else {
                self.coordinatorDelegate?.goToAccidentSuccessRandevu(service: service, date: nil)
            }
        }
    }
    
    func presentCalendar(delegate: CalendarViewControllerDelegate) {
        coordinatorDelegate?.presentCalendar(delegate: delegate)
    }
}
