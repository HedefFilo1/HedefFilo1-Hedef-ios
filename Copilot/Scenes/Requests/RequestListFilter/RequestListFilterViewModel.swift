//
//  RequestListFilterViewModel.swift
//  Copilot
//
//  Created by Jamal on 3/24/24.
//

import Foundation

protocol RequestListFilterVMCoordinatorDelegate: AnyObject {
    
}

protocol RequestListFilterViewModelDelegate: AnyObject {
    
}

protocol RequestListFilterViewModelType: AnyObject {
    var coordinatorDelegate: RequestListFilterVMCoordinatorDelegate? { get set }
    var delegate: RequestListFilterViewModelDelegate? { get set }
    var items: [RequestListFilterItem] { get set }
    var selectedItem: RequestListFilterItem? { get set }
    var title: String { get set }
}

class RequestListFilterViewModel: RequestListFilterViewModelType {
    
    weak var coordinatorDelegate: RequestListFilterVMCoordinatorDelegate?
    weak var delegate: RequestListFilterViewModelDelegate?
   
    var items: [RequestListFilterItem] = []
    var selectedItem: RequestListFilterItem?
    var title: String = ""

}
