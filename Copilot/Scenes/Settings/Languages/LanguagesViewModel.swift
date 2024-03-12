//
//  LanguagesViewModel.swift
//  Copilot
//
//  Created by Jamal on 3/12/24.
//

import Foundation

protocol LanguagesVMCrdinatorDelegate: AnyObject {
    func getBack()
}

protocol LanguagesViewModelDelegate: BaseViewModelDelegate {
    
}

protocol LanguagesViewModelType: AnyObject {
    var coordinatorDelegate: LanguagesVMCrdinatorDelegate? { get set }
    var delegate: LanguagesViewModelDelegate? { get set }
    func getBack()
}

class LanguagesViewModel: LanguagesViewModelType {
    
    weak var coordinatorDelegate: LanguagesVMCrdinatorDelegate?
    weak var delegate: LanguagesViewModelDelegate?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
}
