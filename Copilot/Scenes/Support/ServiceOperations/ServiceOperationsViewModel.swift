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
    func presentFitlers(delegate: FeedbackFilterViewControllerDelegate, items: [FeedbackFilterItem])
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
    func presentFitlers()
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
    
    func presentFitlers() {
        var filterItems = [
            FeedbackFilterItem(title: "BAKIM"),
            FeedbackFilterItem(title: "Ariza")
        ]
        coordinatorDelegate?.presentFitlers(delegate: self, items: filterItems)
    }
}

extension ServiceOperationsViewModel: FeedbackFilterViewControllerDelegate {
    func didTapApply(selectedItem: FeedbackFilterItem) {
        delegate?.reloadData()
    }
}
