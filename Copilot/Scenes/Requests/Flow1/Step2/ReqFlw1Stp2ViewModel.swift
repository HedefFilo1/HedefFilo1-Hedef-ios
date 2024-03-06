//
//  ReqFlw1Stp2ViewModel.swift
//  Copilot
//
//  Created by Jamal on 3/5/24.
//

import Foundation

struct MockRequestFlow1Item {
    let title: String
    var selected = false
}

protocol ReqFlw1Stp2ViewModelCoordinatorDelegate: AnyObject {
    func getBack()
    func goToSuccess()
}

protocol ReqFlw1Stp2ViewModelDelegate: BaseViewModelDelegate {
    
}

protocol ReqFlw1Stp2ViewModelType: AnyObject {
    var coordinatorDelegate: ReqFlw1Stp2ViewModelCoordinatorDelegate? { get set }
    var delegate: ReqFlw1Stp2ViewModelDelegate? { get set }
    var items: [MockRequestFlow1Item] { get set }
    func getBack()
    func goToSuccess()
    func createTask()
}

class ReqFlw1Stp2ViewModel: ReqFlw1Stp2ViewModelType {
    
    weak var coordinatorDelegate: ReqFlw1Stp2ViewModelCoordinatorDelegate?
    weak var delegate: ReqFlw1Stp2ViewModelDelegate?
    
    var items: [MockRequestFlow1Item] = [
        MockRequestFlow1Item(title: "Konfor Paket"),
        MockRequestFlow1Item(title: "Yakıt Yönetim Sistemi"),
        MockRequestFlow1Item(title: "Hedmobil"),
        MockRequestFlow1Item(title: "Lastik"),
        MockRequestFlow1Item(title: "Bakım Valesi"),
        MockRequestFlow1Item(title: "Lastik Valesi"),
        MockRequestFlow1Item(title: "Muayene Valesi"),
        MockRequestFlow1Item(title: "İade Valesi")
    ]
    
    func createTask() {
        let selectedItems = items.filter({ $0.selected })
        guard selectedItems.count > 0 else { return }
        var subjects = [String]()
        for item in selectedItems {
            subjects.append(item.title)
        }
        Loading.shared.show()
        APIService.createTask(subjects: subjects) { [weak self] _, error in
            Loading.shared.hide()
            guard let self = self else { return }
            
            if let error = error {
                self.delegate?.showError(title: Strings.errorTitle,
                                         message: error.message)
            } else {
                self.goToSuccess()
            }
        }
    }
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func goToSuccess() {
        coordinatorDelegate?.goToSuccess()
    }
}
