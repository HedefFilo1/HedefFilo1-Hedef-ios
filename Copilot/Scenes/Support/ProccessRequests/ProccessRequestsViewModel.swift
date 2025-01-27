//
//  ProccessRequestsViewModel.swift
//  Copilot
//
//  Created by Jamal on 3/22/24.
//

import Foundation
import UIKit

struct ProccessRequestsFilterItem {
    let type: WebCategoryEnum
}

protocol ProccessRequestsVMCoordinatorDelegate: AnyObject {
    func getBack()
    func presentFitlers(title: String,
                        delegate: FeedbackFilterViewControllerDelegate,
                        items: [FeedbackFilterItem])
    func presentFeedbackRate(caseId: String, date: String, title: String, description: String)
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
    var filterItem: FeedbackFilterItem? { get set }
    func getBack()
    func presentFitlers()
    func presentFeedbackRate(caseId: String, date: String)
    func getRequests()
}

class ProccessRequestsViewModel: ProccessRequestsViewModelType {
    weak var coordinatorDelegate: ProccessRequestsVMCoordinatorDelegate?
    weak var delegate: ProccessRequestsViewModelDelegate?
    var searchText: String = ""
    var items: [ProccessRequest] = []
    var filterItem: FeedbackFilterItem?
    
    var filteredServices: [ProccessRequest] {
        var notNulls = items // .filter({ $0.displayTitle != nil })
        if let filterItem {
            let type = filterItem.title
            notNulls = notNulls.filter({$0.webCategoryEnum?.title == type})
        }
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
//        let filterItems = [
//            FeedbackFilterItem(title: "Bağlanan Araç İşlemi"),
//            FeedbackFilterItem(title: "Bağlanan Araç İşlemi")
//        ]
        var filterStrings = Set<String>()
        for item in items {
            let value = item.webCategoryEnum?.title ?? ""
            filterStrings.insert(value)
        }
        
        let filterItems = filterStrings.map({ FeedbackFilterItem(title: $0)})
        
        let text = App.getString(key: "copilotapp.help.feedback.process.demand.button_search") ?? ""
        coordinatorDelegate?.presentFitlers(title: text, delegate: self, items: filterItems)
    }
    
    func presentFeedbackRate(caseId: String, date: String) {
        let string = App.getString(key: "copilotapp.system.past.process.request")?.replacingOccurrences(of: "{date}", with: "\(date)") ?? ""
        let title = App.getString(key: "copilotapp.help.feedback.process.requests.satisfaction_survey") ?? ""
        coordinatorDelegate?.presentFeedbackRate(caseId: caseId, date: date, title: title, description: string)
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
        filterItem = selectedItem
        delegate?.reloadData()
    }
}
