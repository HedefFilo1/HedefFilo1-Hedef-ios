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
    func getServices()
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
        let filterItems = [
            FeedbackFilterItem(title: "BAKIM"),
            FeedbackFilterItem(title: "Ariza")
        ]
        coordinatorDelegate?.presentFitlers(title: Strings.serviceProcess,
                                            delegate: self, items: filterItems)
    }
    
    func presentFeedbackRate() {
        coordinatorDelegate?.presentFeedbackRate()
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
//                self.items = model
                print(model)
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
