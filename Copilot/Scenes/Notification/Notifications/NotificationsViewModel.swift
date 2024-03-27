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
    func getNotification()
    func readNotification(id: Int)
    func deleteNotifications(ids: [Int])
    func getBack()
}

class NotificationsViewModel: NotificationsViewModelType {
    
    weak var coordinatorDelegate: NotificationsVMCoordinatorDelegate?
    weak var delegate: NotificationsViewModelDelegate?
    
    var items: [UserNotification]?
    
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
        APIService.readNotification(id: id) { [weak self] model, error in
            Loading.shared.hide()
            guard let self = self else { return }
            
            if let error = error {
                self.delegate?.showError(title: Strings.errorTitle,
                                         message: error.message)
            }
            if let model {
                guard var items else { return }
                for (index, item) in items.enumerated() {
                    if item.id == id {
                        self.items?[index].isRead = true
                    }
                }
                self.delegate?.reloadData()
            }
        }
    }
    
    func deleteNotifications(ids: [Int]) {
        Loading.shared.show()
        APIService.deleteNotifications(ids: ids) { [weak self] model, error in
            Loading.shared.hide()
            guard let self = self else { return }
            
            if let error = error {
                self.delegate?.showError(title: Strings.errorTitle,
                                         message: error.message)
            }
            if let model {
                self.getNotification()
            }
        }
    }
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
}
