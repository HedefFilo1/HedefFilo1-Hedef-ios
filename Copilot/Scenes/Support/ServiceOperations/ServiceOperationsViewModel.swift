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
    func presentFitlers(title: String,
                        delegate: FeedbackFilterViewControllerDelegate,
                        items: [FeedbackFilterItem])
    func presentFeedbackRate(caseId: String)
}

protocol ServiceOperationsViewModelDelegate: BaseViewModelDelegate {
    func reloadData()
}

protocol ServiceOperationsViewModelType: AnyObject {
    var coordinatorDelegate: ServiceOperationsVMCoordinatorDelegate? { get set }
    var delegate: ServiceOperationsViewModelDelegate? { get set }
    var items: [ServiceOperation] { get set }
    var filteredServices: [ServiceOperation] { get}
    var searchText: String { get set }
    func getBack()
    func presentFitlers()
    func presentFeedbackRate(caseId: String)
    func getServices()
}

class ServiceOperationsViewModel: ServiceOperationsViewModelType {
    weak var coordinatorDelegate: ServiceOperationsVMCoordinatorDelegate?
    weak var delegate: ServiceOperationsViewModelDelegate?
    var searchText: String = ""
    var items: [ServiceOperation] = []
    var filteredServices: [ServiceOperation] {
        if searchText.isEmpty {
            return items
        }
        let arr = items.filter {
            $0.dispayTitle.lowercased().contains(searchText.lowercased())
        }
        return arr
    }
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func presentFitlers() {
        let filterItems = [
            FeedbackFilterItem(title: "BAKIM"),
            FeedbackFilterItem(title: "Arıza")
        ]
        coordinatorDelegate?.presentFitlers(title: Strings.serviceProcess,
                                            delegate: self, items: filterItems)
    }
    
    func presentFeedbackRate(caseId: String) {
        coordinatorDelegate?.presentFeedbackRate(caseId: caseId)
    }
    
    func getServices() {
        Loading.shared.show()
        APIService.getServiceOperations { [weak self] model, error in
            Loading.shared.hide()
            guard let self = self else { return }
            
            if let error = error {
                self.delegate?.showError(title: Strings.errorTitle,
                                         message: error.message)
            }
            if let model {
                self.items = model
                self.delegate?.reloadData()
            }
        }
    }
}

extension ServiceOperationsViewModel: FeedbackFilterViewControllerDelegate {
    func didTapApply(selectedItem: FeedbackFilterItem) {
        delegate?.reloadData()
    }
}
