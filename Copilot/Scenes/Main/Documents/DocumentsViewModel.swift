//
//  DocumentsViewModel.swift
//  Copilot
//
//  Created by Jamal on 11/15/23.
//

import Foundation

struct MockDocument {
    let id: Int
    let title: String
    let date: String
}

struct NecessaryDocument {
    let title: String
}

protocol DocumentsViewModelCoordinatorDelegate: AnyObject {
    func goToDocument(document: Document)
    func presentDocumentPopup(document: Document)
    
}

protocol DocumentsViewModelDelegate: BaseViewModelDelegate {
    func reloadData()
}

protocol DocumentsViewModelType: AnyObject {
    var coordinatorDelegate: DocumentsViewModelCoordinatorDelegate? { get set }
    var delegate: DocumentsViewModelDelegate? { get set }
    var documents: [Document]? { get set }
    func delete(document: Document)
    func getDocuments()
    func goToDocument(document: Document)
}

class DocumentsViewModel: DocumentsViewModelType {
    
    weak var coordinatorDelegate: DocumentsViewModelCoordinatorDelegate?
    weak var delegate: DocumentsViewModelDelegate?
    var documents: [Document]?
    
    func getDocuments() {
        Loading.shared.show()
        APIService.getDocuments { [weak self] model, error in
            Loading.shared.hide()
            guard let self = self else { return }
            
            if let model = model {
                self.documents = model
                self.delegate?.reloadData()
            } else
            
            if let error = error {
                self.delegate?.showError(title: Strings.errorTitle,
                                         message: error.message)
            }
        }
    }
    
    func presentDocumentPopup(document: Document) {
        coordinatorDelegate?.presentDocumentPopup(document: document)
    }
    
    func delete(document: Document) {
        documents?.removeAll(where: { $0.id == document.id })
        delegate?.reloadData()
    }
    
    func goToDocument(document: Document) {
        coordinatorDelegate?.goToDocument(document: document)
    }
}
