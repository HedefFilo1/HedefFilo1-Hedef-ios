//
//  DocumentsViewModel.swift
//  Copilot
//
//  Created by Jamal on 11/15/23.
//

import Foundation

struct Document {
    let id: Int
    let title: String
    let date: String
}

struct NecessaryDocument {
    let title: String
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
    var necessaryDocuments: [Document]? { get set }
    var neccessarItems: [NecessaryDocument]? { get set }
    func delete(document: Document)
    func goToDocument()
}

class DocumentsViewModel: DocumentsViewModelType {
    
    weak var coordinatorDelegate: DocumentsViewModelCoordinatorDelegate?
    weak var delegate: DocumentsViewModelDelegate?
    
    var documents: [Document]? = [
        Document(id: 1, title: "Lorem Ipsum Dolar Sit Amet", date: "07.04.2022"),
        Document(id: 2, title: "Lorem Ipsum Dolar Sit Amet", date: "07.04.2022"),
        Document(id: 3, title: "Lorem Ipsum Dolar Sit Amet", date: "07.04.2022")
    ]
    
    var necessaryDocuments: [Document]? = [
        Document(id: 4, title: "Lorem Ipsum Dolar Sit Amet", date: "07.04.2022"),
        Document(id: 5, title: "Lorem Ipsum Dolar Sit Amet", date: "07.04.2022"),
        Document(id: 6, title: "Lorem Ipsum Dolar Sit Amet", date: "07.04.2022")
    ]
    
    var neccessarItems: [NecessaryDocument]? = [
        NecessaryDocument(title: "Araç İade Teslim Dökümanları"),
        NecessaryDocument(title: "Yurt Dışı Çıkış İşlemleri Dökümanları"),
        NecessaryDocument(title: "Lorem Ipsum Dökümanları"),
        NecessaryDocument(title: "Lorem Ipsum Dökümanları")
    ]
    
    func delete(document: Document) {
        documents?.removeAll(where: { $0.id == document.id })
        necessaryDocuments?.removeAll(where: { $0.id == document.id })
    }
    
    func goToDocument() {
        coordinatorDelegate?.goToDocument()
    }
}
