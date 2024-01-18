//
//  ServiceFilterViewModel.swift
//  Copilot
//
//  Created by Jamal on 12/29/23.
//

import Foundation

protocol ServiceFilterVMCoordinatorDelegate: AnyObject {
    
}

protocol ServiceFilterViewModelDelegate: AnyObject {
    
}

protocol ServiceFilterViewModelType: AnyObject {
    var coordinatorDelegate: ServiceFilterVMCoordinatorDelegate? { get set }
    var delegate: ServiceFilterViewModelDelegate? { get set }
    var districts: [String]? { get set }
    var cities: [String]? { get set }
    var selectedDistrict: String? { get set }
    var selectedCity: String? { get set }
    var services: [Supplier]? { get set }
}

class ServiceFilterViewModel: ServiceFilterViewModelType {
    
    weak var coordinatorDelegate: ServiceFilterVMCoordinatorDelegate?
    weak var delegate: ServiceFilterViewModelDelegate?
   
    var districts: [String]? = []
    var cities: [String]? = []
    
    var selectedDistrict: String?
    var selectedCity: String?
    
    var services: [Supplier]? {
        didSet {
            guard let services else { return }
            var districts = Set<String>()
            var cities = Set<String>()
            
            for item in services {
                if let district = item.district {
                    districts.insert(district)
                }
                if let city = item.city {
                    cities.insert(city)
                }
            }
            self.districts = districts.sorted()
            self.cities = cities.sorted()
        }
    }
}
