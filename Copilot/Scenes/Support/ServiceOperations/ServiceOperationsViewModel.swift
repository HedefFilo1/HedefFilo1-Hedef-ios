//
//  ServiceOperationsViewModel.swift
//  Copilot
//
//  Created by Jamal on 3/22/24.
//

import Foundation
import UIKit

protocol ServiceOperationsVMCoordinatorDelegate: AnyObject {
    func getBack()
}

protocol ServiceOperationsViewModelDelegate: BaseViewModelDelegate {
    func reloadData()
}

protocol ServiceOperationsViewModelType: AnyObject {
    var coordinatorDelegate: ServiceOperationsVMCoordinatorDelegate? { get set }
    var delegate: ServiceOperationsViewModelDelegate? { get set }
    var filteredServices: [Supplier] { get}
    var searchText: String { get set }
    func getBack()
}

class ServiceOperationsViewModel: ServiceOperationsViewModelType {
    weak var coordinatorDelegate: ServiceOperationsVMCoordinatorDelegate?
    weak var delegate: ServiceOperationsViewModelDelegate?
    var searchText: String = ""
    var filteredServices: [Supplier] {
        return []
    }
    func getBack() {
        coordinatorDelegate?.getBack()
    }
}
