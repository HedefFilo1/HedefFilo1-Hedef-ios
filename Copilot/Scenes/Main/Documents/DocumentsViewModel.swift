//
//  DocumentsViewModel.swift
//  Copilot
//
//  Created by Jamal on 11/15/23.
//

import Foundation

struct Document {
    let title: String
    let date: String
}

protocol DocumentsViewModelCoordinatorDelegate: AnyObject {
    func goToDocument()
}

protocol DocumentsViewModelDelegate: AnyObject {
    
}

protocol DocumentsViewModelType: AnyObject {
    var coordinatorDelegate: DocumentsViewModelCoordinatorDelegate? { get set }
    var delegate: DocumentsViewModelDelegate? { get set }
    var documents: [Document]? { get set }
    func goToDocument()
}

class DocumentsViewModel: DocumentsViewModelType {
    
    weak var coordinatorDelegate: DocumentsViewModelCoordinatorDelegate?
    weak var delegate: DocumentsViewModelDelegate?
    
    var documents: [Document]? = [
        Document(title: "Lorem Ipsum Dolar Sit Amet", date: "07.04.2022"),
        Document(title: "Lorem Ipsum Dolar Sit Amet", date: "07.04.2022"),
        Document(title: "Lorem Ipsum Dolar Sit Amet", date: "07.04.2022"),
        Document(title: "Lorem Ipsum Dolar Sit Amet", date: "07.04.2022")
    ]
    
    func goToDocument() {
        coordinatorDelegate?.goToDocument()
    }
}
