//
//  FAQQuestionDetailViewModel.swift
//  Copilot
//
//  Created by Jamal on 3/20/24.
//

import Foundation

protocol FAQQuestionDetailVMCrdinatorDlgt: AnyObject {
    func getBack()
}

protocol FAQQuestionDetailViewModelDelegate: BaseViewModelDelegate {
    
}

protocol FAQQuestionDetailViewModelType: AnyObject {
    var coordinatorDelegate: FAQQuestionDetailVMCrdinatorDlgt? { get set }
    var delegate: FAQQuestionDetailViewModelDelegate? { get set }
    var item: FAQQuestionDetail? { get set }
    func getBack()
}

class FAQQuestionDetailViewModel: FAQQuestionDetailViewModelType {
    weak var coordinatorDelegate: FAQQuestionDetailVMCrdinatorDlgt?
    weak var delegate: FAQQuestionDetailViewModelDelegate?
    var item: FAQQuestionDetail?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
 
}
