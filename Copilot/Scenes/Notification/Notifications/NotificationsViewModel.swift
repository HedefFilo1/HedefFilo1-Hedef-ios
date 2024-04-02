//
//  NotificationsViewModel.swift
//  Copilot
//
//  Created by Jamal on 3/27/24.
//

import Foundation

protocol NotificationsVMCoordinatorDelegate: AnyObject {
    func getBack()
}

protocol NotificationsViewModelDelegate: BaseViewModelDelegate {
    func reloadData()
}

protocol NotificationsViewModelType: AnyObject {
    var coordinatorDelegate: NotificationsVMCoordinatorDelegate? { get set }
    var delegate: NotificationsViewModelDelegate? { get set }
    
    var items: [UserNotification]? { get set }
    var showUnreads: Bool { get set }
    var visibleItems: [UserNotification]? { get }
    func getItemIndex(id: Int) -> Int? 
    func getNotification()
    func readNotification(id: Int)
    func deleteNotifications(ids: [Int])
    func getBack()
}

class NotificationsViewModel: NotificationsViewModelType {
    
    weak var coordinatorDelegate: NotificationsVMCoordinatorDelegate?
    weak var delegate: NotificationsViewModelDelegate?
    var showUnreads = false
    var items: [UserNotification]?
    
    var visibleItems: [UserNotification]? {
        if showUnreads {
            return items?.filter { !$0.isRead }
        } else {
            return items
        }
    }
    
    func getItemIndex(id: Int) -> Int? {
        guard let items else { return nil }
        for (index, item) in items.enumerated() where item.id == id {
            return index
        }
        return nil
    }
    
    func getNotification() {
        Loading.shared.show()
        APIService.getNotifications { [weak self] model, error in
            Loading.shared.hide()
            guard let self = self else { return }
            
            if let error = error {
                self.delegate?.showError(title: Strings.errorTitle,
                                         message: error.message)
            }
            if let model {
                //                self.items = model
                self.items = model
                self.delegate?.reloadData()
            }
        }
    }
    
    func readNotification(id: Int) {
        Loading.shared.show()
        APIService.readNotification(id: id) { [weak self] _, error in
            Loading.shared.hide()
            guard let self = self else { return }
            
            if let error = error {
                self.delegate?.showError(title: Strings.errorTitle,
                                         message: error.message)
                return
            }
            
            guard let items = self.items else { return }
            for (index, item) in items.enumerated() where item.id == id {
                self.items?[index].isRead = true
            }
            self.delegate?.reloadData()
            
        }
    }
    
    func deleteNotifications(ids: [Int]) {
        Loading.shared.show()
        APIService.deleteNotifications(ids: ids) { [weak self] _, error in
            Loading.shared.hide()
            guard let self = self else { return }
            
            if let error = error {
                self.delegate?.showError(title: Strings.errorTitle,
                                         message: error.message)
                return
            }
            self.getNotification()
        }
    }
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
}
