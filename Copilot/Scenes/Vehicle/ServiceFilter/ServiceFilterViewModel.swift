//
//  ServiceFilterViewModel.swift
//  Copilot
//
//  Created by Jamal on 12/29/23.
//

import Foundation

struct City {
    let name: String
    var districts: [String] = []
    var order: Int
}

protocol ServiceFilterVMCoordinatorDelegate: AnyObject {
    
}

protocol ServiceFilterViewModelDelegate: AnyObject {
    
}

protocol ServiceFilterViewModelType: AnyObject {
    var coordinatorDelegate: ServiceFilterVMCoordinatorDelegate? { get set }
    var delegate: ServiceFilterViewModelDelegate? { get set }
    var cities: [City] { get set }
    var selectedDistrict: String? { get set }
    var selectedCity: City? { get set }
    var services: [Supplier]? { get set }
}

class ServiceFilterViewModel: ServiceFilterViewModelType {
    
    weak var coordinatorDelegate: ServiceFilterVMCoordinatorDelegate?
    weak var delegate: ServiceFilterViewModelDelegate?
   
    var cities: [City] = []
    
    var selectedDistrict: String?
    var selectedCity: City?
    
    var services: [Supplier]? {
        didSet {
            guard let services else { return }
            var cities = Set<String>()
            
            for item in services {
                if let city = item.city {
                    cities.insert(city)
                }
            }
            
            for item in cities {
                var cityModel = City(name: item, districts: [], order: 10)
                
                var districts = Set<String>()
                for service in services {
                    if service.city == item, let district = service.district {
                        districts.insert(district)
                    }
                }
                cityModel.districts = districts.sorted { (item1, item2) -> Bool in
                    return item1.compare(item2, locale: Locale(identifier: "tr_TR")) == .orderedAscending
                }
                
                if item == "İSTANBUL" {
                    cityModel.order = 1
                    
                } else if item == "ANKARA" {
                    cityModel.order = 2
                    
                } else if item == "İZMİR" {
                    cityModel.order = 3
                }
                self.cities.append(cityModel)
                self.cities = self.cities.sorted { (item1, item2) -> Bool in
                    return item1.name.compare(item2.name, locale: Locale(identifier: "tr_TR")) == .orderedAscending
                }
                
                self.cities = self.cities.sorted(by: { $0.order < $1.order })
            }
            
        }
    }
}
