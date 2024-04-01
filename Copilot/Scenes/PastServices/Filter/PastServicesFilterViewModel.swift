//
//  PastServicesFilterViewModel.swift
//  Copilot
//
//  Created by Jamal on 4/1/24.
//

import Foundation
protocol PastServicesFilterVMCoordinatorDelegate: AnyObject {
    func presentCalendar(delegate: CalendarViewControllerDelegate)
}

protocol PastServicesFilterViewModelDelegate: AnyObject {
    
}

protocol PastServicesFilterViewModelType: AnyObject {
    var coordinatorDelegate: PastServicesFilterVMCoordinatorDelegate? { get set }
    var delegate: PastServicesFilterViewModelDelegate? { get set }
    var cities: [City] { get set }
    var selectedDistrict: String? { get set }
    var selectedCity: City? { get set }
    var services: [PastService]? { get set }
    func presentCalendar(delegate: CalendarViewControllerDelegate)
}

class PastServicesFilterViewModel: PastServicesFilterViewModelType {
    
    weak var coordinatorDelegate: PastServicesFilterVMCoordinatorDelegate?
    weak var delegate: PastServicesFilterViewModelDelegate?
   
    var cities: [City] = []
    
    var selectedDistrict: String?
    var selectedCity: City?
    
    var services: [PastService]? {
        didSet {
//            guard let services else { return }
//            var cities = Set<String>()
//            
//            for item in services {
//                if let city = item.city {
//                    cities.insert(city)
//                }
//            }
//            
//            for item in cities {
//                var cityModel = City(name: item, districts: [], order: 10)
//                
//                var districts = Set<String>()
//                for service in services {
//                    if service.city == item, let district = service.district {
//                        districts.insert(district)
//                    }
//                }
//                cityModel.districts = districts.sorted { (item1, item2) -> Bool in
//                    return item1.compare(item2, locale: Locale(identifier: "tr_TR")) == .orderedAscending
//                }
//                
//                if item == "İSTANBUL" {
//                    cityModel.order = 1
//                    
//                } else if item == "ANKARA" {
//                    cityModel.order = 2
//                    
//                } else if item == "İZMİR" {
//                    cityModel.order = 3
//                }
//                self.cities.append(cityModel)
//                self.cities = self.cities.sorted { (item1, item2) -> Bool in
//                    return item1.name.compare(item2.name, locale: Locale(identifier: "tr_TR")) == .orderedAscending
//                }
//                
//                self.cities = self.cities.sorted(by: { $0.order < $1.order })
//            }
            
        }
    }
    
    func presentCalendar(delegate: CalendarViewControllerDelegate) {
        coordinatorDelegate?.presentCalendar(delegate: delegate)
    }
}
