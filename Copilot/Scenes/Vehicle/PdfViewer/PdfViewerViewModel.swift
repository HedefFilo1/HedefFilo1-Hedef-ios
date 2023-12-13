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
    
}

protocol PdfViewerViewModelType: AnyObject {
    var coordinatorDelegate: PdfViewerViewModelCoordinatorDelegate? { get set }
    var delegate: PdfViewerViewModelDelegate? { get set }
    func getBack()
    func getDocument()
}

class PdfViewerViewModel: PdfViewerViewModelType {
    
    weak var coordinatorDelegate: PdfViewerViewModelCoordinatorDelegate?
    weak var delegate: PdfViewerViewModelDelegate?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func getDocument() {
        Loading.shared.show()
        APIService.getDocuments { [weak self] model, error in
            Loading.shared.hide()
            guard let self = self else { return }
            
            if let model = model {
                print(model)
            } else
            
            if let error = error {
                self.delegate?.showError(title: Strings.errorTitle,
                                         message: error.message)
            }
        }
    }
}
