//
//  PdfViewerViewModel.swift
//  Copilot
//
//  Created by Jamal on 12/13/23.
//

import Foundation

protocol PdfViewerViewModelCoordinatorDelegate: AnyObject {
    func getBack()
}

protocol PdfViewerViewModelDelegate: BaseViewModelDelegate {
    func setDocument()
}

protocol PdfViewerViewModelType: AnyObject {
    var coordinatorDelegate: PdfViewerViewModelCoordinatorDelegate? { get set }
    var delegate: PdfViewerViewModelDelegate? { get set }
    var document: Document? { get set }
    var conetent: DocumentContent? { get set }
    func getBack()
    func getDocument()
}

class PdfViewerViewModel: PdfViewerViewModelType {
    
    weak var coordinatorDelegate: PdfViewerViewModelCoordinatorDelegate?
    weak var delegate: PdfViewerViewModelDelegate?
    var document: Document?
    var conetent: DocumentContent?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func getDocument() {
        guard let id = document?.id else { return }
        Loading.shared.show()
        APIService.getDocument(id: id) { [weak self] model, error in
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
}
