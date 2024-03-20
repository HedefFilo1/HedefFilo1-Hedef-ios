//
//  FAQQeustionViewModel.swift
//  Copilot
//
//  Created by Jamal on 3/20/24.
//

import Foundation

protocol FAQQuestionVMCrdinatorDlgt: AnyObject {
    func getBack()
    func goToFAQQuestionDetail(item: FAQQuestionDetail)
}

protocol FAQQuestionViewModelDelegate: BaseViewModelDelegate {
    func reloadData()
}

protocol FAQQuestionViewModelType: AnyObject {
    var coordinatorDelegate: FAQQuestionVMCrdinatorDlgt? { get set }
    var delegate: FAQQuestionViewModelDelegate? { get set }
    var item: FAQQuestion? { get set }
    var items: [FAQQuestionDetail]? { get set }
    func getBack()
    func getQuestion()
    func goToFAQQuestionDetail(item: FAQQuestionDetail)
}

class FAQQuestionViewModel: FAQQuestionViewModelType {
    weak var coordinatorDelegate: FAQQuestionVMCrdinatorDlgt?
    weak var delegate: FAQQuestionViewModelDelegate?
    var items: [FAQQuestionDetail]?
    var item: FAQQuestion?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func getQuestion() {
        guard let item else { return}
        Loading.shared.show()
        APIService.getFAQQuestion(categoryId: item.id) { [weak self] model, error in
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
    
    func goToFAQQuestionDetail(item: FAQQuestionDetail) {
        coordinatorDelegate?.goToFAQQuestionDetail(item: item)
    }
}
