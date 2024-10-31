//
//  RequestListViewModel.swift
//  Copilot
//
//  Created by Jamal on 3/17/24.
//

import Foundation

struct RequestListFilterItem {
    let title: String
}

protocol RequestListTasksVMCrdntrDelegate: AnyObject {
    func getBack()
    func goToRequestDetail(item: Task)
    func presentSort(delegate: SortViewControllerDelegate)
    func presentFitlers(title: String,
                        delegate: RequestListFilterViewControllerDelegate,
                        items: [RequestListFilterItem])
    func showRequestsList()
}

protocol RequestListTasksViewModelDelegate: BaseViewModelDelegate {
    func reloadData()
}

protocol RequestListTasksViewModelType: AnyObject {
    var coordinatorDelegate: RequestListTasksVMCrdntrDelegate? { get set }
    var delegate: RequestListTasksViewModelDelegate? { get set }
    var tasks: [Task]? { get set }
    var filteredTasks: [Task] { get }
    var searchText: String { get set }
    var filterItem: RequestListFilterItem? { get set }
    func presentFitlers()
    func presentSort()
    func getBack()
    func goToRequestDetail(item: Task)
    func getTasks()
    func showRequestsList()
}

class RequestListTasksViewModel: RequestListTasksViewModelType {
    
    weak var coordinatorDelegate: RequestListTasksVMCrdntrDelegate?
    weak var delegate: RequestListTasksViewModelDelegate?
    var tasks: [Task]?
    var searchText: String = ""
    var filterItem: RequestListFilterItem?
    
    var filteredTasks: [Task] {
        var notNulls = tasks?.filter({ $0.subjectResult != nil })
        if let filterItem {
            let type = filterItem.title
            notNulls = notNulls?.filter({$0.subjectResult == type})
        }
        if searchText.isEmpty {
            return notNulls ?? []
        }
        let arr = notNulls?.filter {
            return ($0.subjectResult ?? "").lowercased().contains(searchText.lowercased())
        }
        return arr ?? []
    }
    
    func presentFitlers() {
        let arr = tasks ?? []
        var filterStrings = Set<String>()
        for item in arr {
            let value = item.statusTextResult ?? ""
            filterStrings.insert(value)
        }
        
        let filterItems = filterStrings.map({ RequestListFilterItem(title: $0)})
        
        let text = App.getString(key: "copilotapp.help.feedback.process.demand.button_search") ?? ""
        coordinatorDelegate?.presentFitlers(title: text, delegate: self, items: filterItems)
    }
    
    func showRequestsList() {
        coordinatorDelegate?.showRequestsList()
    }
    
    func presentSort() {
        coordinatorDelegate?.presentSort(delegate: self)
    }
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func goToRequestDetail(item: Task) {
        coordinatorDelegate?.goToRequestDetail(item: item)
    }
    
    func getTasks() {
        Loading.shared.show(presented: true)
        APIService.getTasks { [weak self] model, error in
            Loading.shared.hide()
            guard let self = self else {return}
            
            if let model = model {
                self.tasks = model
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

extension RequestListTasksViewModel:
    RequestListFilterViewControllerDelegate,
    SortViewControllerDelegate {
    
    func didTapApply(ascending: Bool) {
        if ascending {
            let sorted = tasks?.sorted { $0.date ?? Date() < $1.date ?? Date() }
            tasks = sorted
        } else {
            let sorted = tasks?.sorted { $0.date ?? Date() > $1.date ?? Date() }
            tasks = sorted
        }
        
        delegate?.reloadData()
    }
    
    func didTapApply(selectedItem: RequestListFilterItem) {
        filterItem = selectedItem
        delegate?.reloadData()
    }
}
