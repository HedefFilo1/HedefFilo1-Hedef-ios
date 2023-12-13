//
//  DocumentPopupViewModel.swift
//  Copilot
//
//  Created by Jamal on 11/23/23.
//

import Foundation

protocol DocumentPopupVMCoordinatorDelegate: AnyObject {
    func dismiss(_: DocumentPopupViewModelType, deletedDocument: Document?)
}

protocol DocumentPopupViewModelDelegate: AnyObject {
    func showSuccess(title: String, message: String)
    func showError(title: String, message: String)
}

protocol DocumentPopupViewModelType: AnyObject {
    var delegate: DocumentPopupViewModelDelegate? { get set }
    var document: Document? { get set }
    func dismiss()
    func deleteAndDismiss()
}

class DocumentPopupViewModel: DocumentPopupViewModelType {
    
    // MARK: - Delegates
    var coordinatorDelegate: DocumentPopupVMCoordinatorDelegate?
    weak var delegate: DocumentPopupViewModelDelegate?
    var document: Document?
    
    func dismiss() {
        coordinatorDelegate?.dismiss(self, deletedDocument: nil)
    }
    
    func deleteAndDismiss() {
        if let doc = document {
            coordinatorDelegate?.dismiss(self, deletedDocument: doc)
        }
    }
    
}
