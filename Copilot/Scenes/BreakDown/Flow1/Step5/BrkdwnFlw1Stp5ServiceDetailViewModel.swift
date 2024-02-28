//
//  BrkdwnFlw1Stp5BrkdwnFlw1Stp5ServiceDetailViewModel.swift
//  Copilot
//
//  Created by Jamal on 2/7/24.
//

import Foundation
import CoreLocation
import MapKit

protocol BrkdwnFlw1Stp5ServiceDetailVMCrdintrDlgt: AnyObject {
    func getBack()
    func goToBreakDownSuccessRandevu(service: Supplier?, appointment: Case?, date: Date?)
    func presentCalendar(delegate: CalendarViewControllerDelegate)
}

protocol BrkdwnFlw1Stp5ServiceDetailVMdlDlgt: BaseViewModelDelegate {
    
}

protocol BrkdwnFlw1Stp5ServiceDetailViewModelType: AnyObject {
    var coordinatorDelegate: BrkdwnFlw1Stp5ServiceDetailVMCrdintrDlgt? { get set }
    var delegate: BrkdwnFlw1Stp5ServiceDetailVMdlDlgt? { get set }
    var towTruck: Bool { get set }
    var service: Supplier? { get set }
    var appointment: Case? { get set }
    func getBack()
    func createTowTruckRandevu()
    func createRandevu(with date: Date, hour: String, minute: String)
    func updateRandevu(with date: Date, hour: String, minute: String) 
    func openGoogleMap(latitude: Double, longitude: Double)
    func openAppleMap(latitude: Double, longitude: Double)
    func presentCalendar(delegate: CalendarViewControllerDelegate)
}

class BrkdwnFlw1Stp5ServiceDetailViewModel: BrkdwnFlw1Stp5ServiceDetailViewModelType {
    weak var coordinatorDelegate: BrkdwnFlw1Stp5ServiceDetailVMCrdintrDlgt?
    weak var delegate: BrkdwnFlw1Stp5ServiceDetailVMdlDlgt?
    
    var towTruck: Bool = false
    var service: Supplier?
    var appointment: Case?
    
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
        //                if true {
        //                    self.coordinatorDelegate?.goToBreakDownSuccessRandevu(service: service!, appointment: nil, date: nil)
        //                    return
        //                }
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
                self.coordinatorDelegate?.goToBreakDownSuccessRandevu(service: service,
                                                                      appointment: nil,
                                                                      date: nil)
            }
        }
    }
    
    func createRandevu(with date: Date, hour: String, minute: String) {
        guard let hour = Int(hour), let min = Int(minute),
              let date = date.setTime(hour: hour, min: min),
              let service else { return }
#if DEV_DEBUG
        //        if true {
        //            self.coordinatorDelegate?.goToBreakDownSuccessRandevu(service: service, appointment: nil, date: date)
        //            return
        //        }
        
#endif
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
                self.coordinatorDelegate?.goToBreakDownSuccessRandevu(service: service,
                                                                      appointment: nil,
                                                                      date: date)
            }
        }
    }
    
    func updateRandevu(with date: Date, hour: String, minute: String) {
        guard let appointment,
              let hour = Int(hour), let min = Int(minute),
              let date = date.setTime(hour: hour, min: min) else { return }
        Loading.shared.show()
        APIService.updateCase(caseId: appointment.id ?? "",
                              appointmentDate: date) { [weak self] _, error in
            Loading.shared.hide()
            guard let self = self else { return }
            
            if let error = error {
                self.delegate?.showError(title: Strings.errorTitle,
                                         message: error.message)
            } else {
                self.coordinatorDelegate?.goToBreakDownSuccessRandevu(service: nil,
                                                                      appointment: appointment,
                                                                      date: date)
            }
        }
    }
    
    func presentCalendar(delegate: CalendarViewControllerDelegate) {
        coordinatorDelegate?.presentCalendar(delegate: delegate)
    }
}
