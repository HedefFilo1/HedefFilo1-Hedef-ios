//
//  AccFlw1Stp1ViewModel.swift
//  Copilot
//
//  Created by Jamal on 2/16/24.
//

import Foundation

protocol AccFlw1Stp1VMCrdinatorDlgt: AnyObject {
    func getBack()
}

protocol AccFlw1Stp1ViewModelDelegate: BaseViewModelDelegate {
    
}

protocol AccFlw1Stp1ViewModelType: AnyObject {
    var coordinatorDelegate: AccFlw1Stp1VMCrdinatorDlgt? { get set }
    var delegate: AccFlw1Stp1ViewModelDelegate? { get set }
    func getBack()
}

class AccFlw1Stp1ViewModel: AccFlw1Stp1ViewModelType {
    
    weak var coordinatorDelegate: AccFlw1Stp1VMCrdinatorDlgt?
    weak var delegate: AccFlw1Stp1ViewModelDelegate?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
}
