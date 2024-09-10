//
//  DocumentLoadViewModel.swift
//  Copilot
//
//  Created by Jamal on 9/10/24.
//

import Foundation
import PDFKit

protocol DocumentLoadViewModelCoordinatorDelegate: AnyObject {
    func getBack()
}

protocol DocumentLoadViewModelDelegate: BaseViewModelDelegate {
    func showShareView(url: URL)
    func setDocument()
}

protocol DocumentLoadViewModelType: AnyObject {
    var coordinatorDelegate: DocumentLoadViewModelCoordinatorDelegate? { get set }
    var delegate: DocumentLoadViewModelDelegate? { get set }
    var conetent: DocumentContent? { get set }
    var title: String? { get set }
    func getBack()
    func getDocument()
    func downloadDoc()
}

class DocumentLoadViewModel: DocumentLoadViewModelType {
    
    weak var coordinatorDelegate: DocumentLoadViewModelCoordinatorDelegate?
    weak var delegate: DocumentLoadViewModelDelegate?
    var conetent: DocumentContent?
    var title: String?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func getDocument() {
        Loading.shared.show()
        APIService.getDocumentPolicy { [weak self] model, error in
            Loading.shared.hide()
            guard let self = self else { return }
            
            if let model = model {
                self.conetent = model
                self.delegate?.setDocument()
            } else
            
            if let error = error {
                self.delegate?.showError(title: Strings.errorTitle,
                                         message: error.message)
            }
            
            if model == nil, error == nil {
                self.delegate?.setDocument()
            }
        }
    }
    
    func downloadDoc() {
        if let content = conetent {
            saveBase64StringToPDF(document: content)
        }
    }
}

extension DocumentLoadViewModel: DocumentDownloader {
    
    func showShareView(url: URL) {
        delegate?.showShareView(url: url)
    }
    
    func showError(title: String, message: String) {
        delegate?.showError(title: title, message: message)
    }
}
