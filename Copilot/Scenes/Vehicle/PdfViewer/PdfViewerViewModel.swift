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
}

class PdfViewerViewModel: PdfViewerViewModelType {
    
    weak var coordinatorDelegate: PdfViewerViewModelCoordinatorDelegate?
    weak var delegate: PdfViewerViewModelDelegate?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
}
