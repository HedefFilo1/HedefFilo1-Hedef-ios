//
//  DocmentViewModel.swift
//  Copilot
//
//  Created by Jamal on 11/15/23.
//

import Foundation

protocol DocumentViewModelCoordinatorDelegate: AnyObject {
    func getBack()
}

protocol DocumentViewModelDelegate: AnyObject {
    
}

protocol DocumentViewModelType: AnyObject {
    var coordinatorDelegate: DocumentViewModelCoordinatorDelegate? { get set }
    var delegate: DocumentViewModelDelegate? { get set }
    func getBack()
}

class DocumentViewModel: DocumentViewModelType {
    
    weak var coordinatorDelegate: DocumentViewModelCoordinatorDelegate?
    weak var delegate: DocumentViewModelDelegate?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
}
