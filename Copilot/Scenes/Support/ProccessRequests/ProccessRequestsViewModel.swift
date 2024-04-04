//
//  ProccessRequestsViewModel.swift
//  Copilot
//
//  Created by Jamal on 3/22/24.
//

import Foundation
import UIKit

struct ProccessRequestsItem {
    let title: String
}

protocol ProccessRequestsVMCoordinatorDelegate: AnyObject {
    func getBack()
    func presentFitlers(title: String,
                        delegate: FeedbackFilterViewControllerDelegate,
                        items: [FeedbackFilterItem])
    func presentFeedbackRate()
}

protocol ProccessRequestsViewModelDelegate: BaseViewModelDelegate {
    func reloadData()
}

protocol ProccessRequestsViewModelType: AnyObject {
    var coordinatorDelegate: ProccessRequestsVMCoordinatorDelegate? { get set }
    var delegate: ProccessRequestsViewModelDelegate? { get set }
    var items: [ProccessRequest] { get set }
    var filteredServices: [ProccessRequest] { get}
    var searchText: String { get set }
    func getBack()
    func presentFitlers()
    func presentFeedbackRate()
    func getRequests()
}

class ProccessRequestsViewModel: ProccessRequestsViewModelType {
    weak var coordinatorDelegate: ProccessRequestsVMCoordinatorDelegate?
    weak var delegate: ProccessRequestsViewModelDelegate?
    var searchText: String = ""
    var items: [ProccessRequest] = []
    
    var filteredServices: [ProccessRequest] {
        var notNulls = items.filter({ $0.supplierName != nil })
        if searchText.isEmpty {
            return notNulls
        }
        let arr = notNulls.filter {
//            guard let supplier = $0.supplierName else { return false }
            return ($0.supplierName ?? "").lowercased().contains(searchText.lowercased())
        }
        return arr
    }
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func presentFitlers() {
        let filterItems = [
            FeedbackFilterItem(title: "Bağlanan Araç İşlemi"),
            FeedbackFilterItem(title: "Bağlanan Araç İşlemi")
        ]
        coordinatorDelegate?.presentFitlers(title: Strings.proceduralRequestProcess, delegate: self, items: filterItems)
    }
    
    func presentFeedbackRate() {
        coordinatorDelegate?.presentFeedbackRate()
    }
    
    func getRequests() {
        Loading.shared.show()
        APIService.getProccessRequests { [weak self] model, error in
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

extension ProccessRequestsViewModel: FeedbackFilterViewControllerDelegate {
    func didTapApply(selectedItem: FeedbackFilterItem) {
        delegate?.reloadData()
    }
}
