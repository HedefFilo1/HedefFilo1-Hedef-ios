//
//  FAQViewModel.swift
//  Copilot
//
//  Created by Jamal on 3/19/24.
//

import Foundation

struct FAQItem {
    let title: String
}

protocol FAQVMCrdinatorDlgt: AnyObject {
    func getBack()
    func getBackToHome()
}

protocol FAQViewModelDelegate: BaseViewModelDelegate {
    
}

protocol FAQViewModelType: AnyObject {
    var coordinatorDelegate: FAQVMCrdinatorDlgt? { get set }
    var delegate: FAQViewModelDelegate? { get set }
    var items: [FAQItem] { get set }
    func getBack()
}

class FAQViewModel: FAQViewModelType {
    weak var coordinatorDelegate: FAQVMCrdinatorDlgt?
    weak var delegate: FAQViewModelDelegate?
    var items = [
        FAQItem(title: "title")
    ]
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
}
