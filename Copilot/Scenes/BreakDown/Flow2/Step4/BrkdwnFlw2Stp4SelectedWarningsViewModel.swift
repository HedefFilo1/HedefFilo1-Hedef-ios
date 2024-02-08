//
//  BrkdwnFlw2Stp4SelectedWarningsViewModel.swift
//  Copilot
//
//  Created by Jamal on 2/8/24.
//

import Foundation

struct MockWarning {
    let id: Int
    let title: String
    let image: String
}

protocol BrkdnFlw2Stp4SelectedWrnngsVMCrdntrDlgt: AnyObject {
    func getBack()
    
}

protocol BrkdwnFlw2Stp4SelectedWarningsVMDelegate: BaseViewModelDelegate {
    func setBrkdwnFlw2Stp4SelectedWarnings()
}

protocol BrkdwnFlw2Stp4SelectedWarningsVMType: AnyObject {
    var coordinatorDelegate: BrkdnFlw2Stp4SelectedWrnngsVMCrdntrDlgt? { get set }
    var delegate: BrkdwnFlw2Stp4SelectedWarningsVMDelegate? { get set }
    var warnings: [MockWarning]? { get set }
    func getBack()
    
}

class BrkdwnFlw2Stp4SelectedWarningsViewModel: BrkdwnFlw2Stp4SelectedWarningsVMType {
    
    weak var coordinatorDelegate: BrkdnFlw2Stp4SelectedWrnngsVMCrdntrDlgt?
    weak var delegate: BrkdwnFlw2Stp4SelectedWarningsVMDelegate?
    
    var warnings: [MockWarning]? = [
        MockWarning(id: 1, title: "Yanan İkaz Işığı", image: "absWarning"),
        MockWarning(id: 2, title: "Yanan İkaz Işığı", image: "absWarning")
    ]
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
}
