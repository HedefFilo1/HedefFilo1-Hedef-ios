//
//  DocumentsViewModel.swift
//  Copilot
//
//  Created by Jamal on 11/15/23.
//

import Foundation

protocol DocumentsViewModelCoordinatorDelegate: AnyObject {
    func goToDocument(document: Document)
    func presentDocumentPopup(document: Document)
    
}

protocol DocumentsViewModelDelegate: BaseViewModelDelegate {
    func showShareView(url: URL)
    func reloadData()
}

protocol DocumentsViewModelType: AnyObject {
    var coordinatorDelegate: DocumentsViewModelCoordinatorDelegate? { get set }
    var delegate: DocumentsViewModelDelegate? { get set }
    var documents: [Document]? { get set }
    func delete(document: Document)
    func getDocuments()
    func getDocument(document: Document)
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

// MARK: Save and Downloading pdf
protocol DocumentDownloader: AnyObject {
    func showShareView(url: URL)
    func showError(title: String, message: String)
}

extension DocumentDownloader {
    
    func getDocument(document: Document) {
        
        Loading.shared.show()
        APIService.getDocument(id: document.id) { [weak self] model, error in
            Loading.shared.hide()
            guard let self = self else { return }
            
            if let model = model {
                self.saveBase64StringToPDF(document: model)
            } else
            
            if let error = error {
                self.showError(title: Strings.errorTitle, message: error.message)
            }
            
            if model == nil, error == nil {
                self.showError(title: Strings.errorTitle, message: "Document Data is empty.")
            }
        }
    }
    
    func saveBase64StringToPDF(document: DocumentContent) {
        guard
            var documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last,
            let convertedData = Data(base64Encoded: document.content)
        else {
            return
        }
        let fileName = "\(document.name).pdf"
        documentsURL.appendPathComponent(fileName)
        
        do {
            try convertedData.write(to: documentsURL)
            showSavedPdf(url: documentsURL.absoluteString, fileName: fileName)
        } catch {
            showError(title: Strings.errorTitle, message: error.localizedDescription)
        }
    }
    
    func showSavedPdf(url: String, fileName: String) {
        
        do {
            let docURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let contents = try FileManager.default.contentsOfDirectory(at: docURL, includingPropertiesForKeys: [.fileResourceTypeKey], options: .skipsHiddenFiles)
            
            for url in contents where url.description.contains(fileName) {
                showShareView(url: url)
            }
        } catch {
            showError(title: Strings.errorTitle, message: error.localizedDescription)
        }
    }
    
}

extension DocumentsViewModel: DocumentDownloader {
    
    func showShareView(url: URL) {
        delegate?.showShareView(url: url)
    }
    
    func showError(title: String, message: String) {
        delegate?.showError(title: title, message: message)
    }
}
