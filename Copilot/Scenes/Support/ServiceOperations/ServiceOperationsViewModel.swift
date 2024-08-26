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
    func presentFeedbackRate(caseId: String, date: String, title: String, description: String)
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
    func presentFeedbackRate(caseId: String, date: String)
    func getServices()
}

class ServiceOperationsViewModel: ServiceOperationsViewModelType {
    weak var coordinatorDelegate: ServiceOperationsVMCoordinatorDelegate?
    weak var delegate: ServiceOperationsViewModelDelegate?
    var searchText: String = ""
    var items: [ServiceOperation] = []
    var filterItem: FeedbackFilterItem?
    
    var filteredServices: [ServiceOperation] {
        var notNulls = items
        if let filterItem {
            notNulls = notNulls.filter({$0.type == filterItem.title})
        }
        
        if searchText.isEmpty {
            return notNulls
        }
        
        let arr = notNulls.filter {
            $0.dispayTitle.lowercased().contains(searchText.lowercased())
        }
        return arr
    }
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func presentFitlers() {
        //        let filterItems = [
        //            FeedbackFilterItem(title: "BAKIM"),
        //            FeedbackFilterItem(title: "Arıza")
        //        ]
        
        
        var filterStrings = Set<String>()
        for item in items {
            let value = item.type
            filterStrings.insert(value)
        }
        
        let filterItems = filterStrings.map({ FeedbackFilterItem(title: $0)})
        
        let text = App.getString(key: "copilotapp.help.feedback.service.operation.dropdown_description") ?? Strings.serviceProcess
        coordinatorDelegate?.presentFitlers(title: text,
                                            delegate: self, items: filterItems)
    }
    
    func presentFeedbackRate(caseId: String, date: String) {
        let string = App.getString(key: "copilotapp.system.past.service.operation")?.replacingOccurrences(of: "{date}", with: "\(date)") ?? ""
        let title = App.getString(key: "copilotapp.help.feedback.service.operation.satisfaction_survey") ?? ""
        coordinatorDelegate?.presentFeedbackRate(caseId: caseId, date: date, title: title, description: string)
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
        filterItem = selectedItem
        delegate?.reloadData()
    }
}
