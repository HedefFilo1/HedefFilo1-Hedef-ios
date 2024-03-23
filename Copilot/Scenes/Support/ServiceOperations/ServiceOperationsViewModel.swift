//
//  ServiceOperationsViewModel.swift
//  Copilot
//
//  Created by Jamal on 3/22/24.
//

import Foundation
import UIKit

struct ServiceOperationsItem {
    let title: String
}

protocol ServiceOperationsVMCoordinatorDelegate: AnyObject {
    func getBack()
    func presentFitlers(delegate: FeedbackFilterViewControllerDelegate, items: [FeedbackFilterItem])
    func presentFeedbackRate()
}

protocol ServiceOperationsViewModelDelegate: BaseViewModelDelegate {
    func reloadData()
}

protocol ServiceOperationsViewModelType: AnyObject {
    var coordinatorDelegate: ServiceOperationsVMCoordinatorDelegate? { get set }
    var delegate: ServiceOperationsViewModelDelegate? { get set }
    var filteredServices: [ServiceOperationsItem] { get}
    var searchText: String { get set }
    func getBack()
    func presentFitlers()
    func presentFeedbackRate()
}

class ServiceOperationsViewModel: ServiceOperationsViewModelType {
    weak var coordinatorDelegate: ServiceOperationsVMCoordinatorDelegate?
    weak var delegate: ServiceOperationsViewModelDelegate?
    var searchText: String = ""
    var filteredServices: [ServiceOperationsItem] {
        return [ServiceOperationsItem(title: "something")]
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
    
    func presentFeedbackRate() {
        coordinatorDelegate?.presentFeedbackRate()
    }
}

extension ServiceOperationsViewModel: FeedbackFilterViewControllerDelegate {
    func didTapApply(selectedItem: FeedbackFilterItem) {
        delegate?.reloadData()
    }
}
