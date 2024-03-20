//
//  FAQViewModel.swift
//  Copilot
//
//  Created by Jamal on 3/19/24.
//

import Foundation

protocol FAQVMCrdinatorDlgt: AnyObject {
    func getBack()
    func goToFAQQuestion(item: FAQQuestion)
}

protocol FAQViewModelDelegate: BaseViewModelDelegate {
    func reloadData()
}

protocol FAQViewModelType: AnyObject {
    var coordinatorDelegate: FAQVMCrdinatorDlgt? { get set }
    var delegate: FAQViewModelDelegate? { get set }
    var items: [FAQQuestion]? { get set }
    func getBack()
    func getQuestions()
    func goToFAQQuestion(item: FAQQuestion)
}

class FAQViewModel: FAQViewModelType {
    weak var coordinatorDelegate: FAQVMCrdinatorDlgt?
    weak var delegate: FAQViewModelDelegate?
    var items: [FAQQuestion]?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func getQuestions() {
        Loading.shared.show()
        APIService.getFAQQuestions { [weak self] model, error in
            Loading.shared.hide()
            guard let self = self else { return }
            
            if let error = error {
                self.delegate?.showError(title: Strings.errorTitle,
                                         message: error.message)
            }
            if let model {
                self.items = model
                self.delegate?.reloadData()
            }
        }
    }
    
    func goToFAQQuestion(item: FAQQuestion) {
        coordinatorDelegate?.goToFAQQuestion(item: item)
    }
}
