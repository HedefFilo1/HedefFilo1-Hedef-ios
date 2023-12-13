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
    func goToDocument()
    func presentDocumentPopup(document: MockDocument)
    
}

protocol DocumentsViewModelDelegate: AnyObject {
    func reloadData()
}

protocol DocumentsViewModelType: AnyObject {
    var coordinatorDelegate: DocumentsViewModelCoordinatorDelegate? { get set }
    var delegate: DocumentsViewModelDelegate? { get set }
    var documents: [MockDocument]? { get set }
    var necessaryDocuments: [MockDocument]? { get set }
    func delete(document: MockDocument)
    func goToDocument()
}

class DocumentsViewModel: DocumentsViewModelType {
    
    weak var coordinatorDelegate: DocumentsViewModelCoordinatorDelegate?
    weak var delegate: DocumentsViewModelDelegate?
    
    var documents: [MockDocument]? = [
        MockDocument(id: 1, title: "Lorem Ipsum Dolar Sit Amet", date: "07.04.2022"),
        MockDocument(id: 2, title: "Lorem Ipsum Dolar Sit Amet", date: "07.04.2022"),
        MockDocument(id: 3, title: "Lorem Ipsum Dolar Sit Amet", date: "07.04.2022")
    ]
    
    var necessaryDocuments: [MockDocument]? = [
        MockDocument(id: 4, title: "Lorem Ipsum Dolar Sit Amet", date: "07.04.2022"),
        MockDocument(id: 5, title: "Lorem Ipsum Dolar Sit Amet", date: "07.04.2022"),
        MockDocument(id: 6, title: "Lorem Ipsum Dolar Sit Amet", date: "07.04.2022")
    ]
    
    func presentDocumentPopup(document: MockDocument) {
        coordinatorDelegate?.presentDocumentPopup(document: document)
    }
    
    func delete(document: MockDocument) {
        documents?.removeAll(where: { $0.id == document.id })
        delegate?.reloadData()
    }
    
    func goToDocument() {
        coordinatorDelegate?.goToDocument()
    }
}
