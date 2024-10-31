//
//  RequestListViewModel.swift
//  Copilot
//
//  Created by Jamal on 3/17/24.
//

import Foundation

protocol RequestListRequestsVMCrdntrDelegate: AnyObject {
    func getBack()
    func goToRequestDetail(item: Task)
    func presentSort(newToOldText: String,
                     oldToNewText: String,
                     applyText: String,
                     delegate: SortViewControllerDelegate)
    func presentFitlers(title: String,
                        placeholder: String,
                        buttonText: String,
                        delegate: RequestListFilterViewControllerDelegate,
                        items: [RequestListFilterItem])
    func showTasksList()
}

protocol RequestListRequestsViewModelDelegate: BaseViewModelDelegate {
    func reloadData()
}

protocol RequestListRequestsViewModelType: AnyObject {
    var coordinatorDelegate: RequestListRequestsVMCrdntrDelegate? { get set }
    var delegate: RequestListRequestsViewModelDelegate? { get set }
    
    var filteredRequests: [Demand] { get }
    var searchText: String { get set }
    var filterItem: RequestListFilterItem? { get set }
    var requests: [Demand]? { get set }
    func presentFitlers()
    func presentSort()
    func getBack()
    func goToRequestDetail(item: Task)
    func getRequests()
    func showTasksList()
}

class RequestListRequestsViewModel: RequestListRequestsViewModelType {
    
    weak var coordinatorDelegate: RequestListRequestsVMCrdntrDelegate?
    weak var delegate: RequestListRequestsViewModelDelegate?
    var requests: [Demand]?
    var searchText: String = ""
    var filterItem: RequestListFilterItem?
    
    var filteredRequests: [Demand] {
        var notNulls = requests?.filter({ $0.recordTypeResult != nil })
        if let filterItem {
            let type = filterItem.title
            notNulls = notNulls?.filter({$0.recordTypeResult == type})
        }
        if searchText.isEmpty {
            return notNulls ?? []
        }
        let arr = notNulls?.filter {
            return ($0.recordTypeResult ?? "").lowercased().contains(searchText.lowercased())
        }
        return arr ?? []
    }
    
    func presentFitlers() {
        let arr = requests ?? []
        var filterStrings = Set<String>()
        for item in arr {
            let value = item.statusTextResult ?? ""
            filterStrings.insert(value)
        }
        
        let filterItems = filterStrings.map({ RequestListFilterItem(title: $0)})
        
        let title = App.getString(key: "copilotapp.service.service.list.processrequest.filter.title") ?? ""
        let placeholder = App.getString(key: "copilotapp.service.service.list.processrequest.filter.search.request") ?? ""
        let buttonText = App.getString(key: "copilotapp.service.service.list.processrequest.filter.apply") ?? ""
        coordinatorDelegate?.presentFitlers(title: title,
                                            placeholder: placeholder,
                                            buttonText: buttonText,
                                            delegate: self,
                                            items: filterItems)
    }
    
    func showTasksList() {
        coordinatorDelegate?.showTasksList()
    }
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func goToRequestDetail(item: Task) {
        coordinatorDelegate?.goToRequestDetail(item: item)
    }
    
    func presentSort() {
        let newToOld = App.getString(key: "copilotapp.service.service.list.processrequest.sort.new.old") ?? ""
        let oldToNew = App.getString(key: "copilotapp.service.service.list.processrequest.sort.old.new") ?? ""
        
        let applyText = App.getString(key: "copilotapp.service.service.list.processrequest.sort.apply") ?? ""
        coordinatorDelegate?.presentSort(newToOldText: newToOld,
                                         oldToNewText: oldToNew,
                                         applyText: applyText,
                                         delegate: self)
    }
    
    func getRequests() {
        Loading.shared.show(presented: true)
        APIService.getRequests { [weak self] model, error in
            Loading.shared.hide()
            guard let self = self else {return}
            
            if let model = model {
                self.requests = model
                self.delegate?.reloadData()
            } else
            
            if let error = error {
                self.delegate?.showError(title: Strings.errorTitle,
                                         message: error.message)
                return
            }
        }
    }
}

extension RequestListRequestsViewModel:
    RequestListFilterViewControllerDelegate,
    SortViewControllerDelegate {
    
    func didTapApply(ascending: Bool) {
        if ascending {
            let sorted = requests?.sorted { $0.date ?? Date() < $1.date ?? Date() }
            requests = sorted
        } else {
            let sorted = requests?.sorted { $0.date ?? Date() > $1.date ?? Date() }
            requests = sorted
        }
        
        delegate?.reloadData()
    }
    
    func didTapApply(selectedItem: RequestListFilterItem) {
        filterItem = selectedItem
        delegate?.reloadData()
    }
}
