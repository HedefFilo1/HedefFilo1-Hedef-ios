//
//  AccFlw5Stp3DeclareViewModel.swift
//  Copilot
//
//  Created by Jamal on 2/23/24.
//

import Foundation

protocol AccFlw5Stp3DeclareVMCrdinatorDlgt: AnyObject {
    func getBack()
    func goToAccFlow5Step4()
    func goToGuide()
}

protocol AccFlw5Stp3DeclareViewModelDelegate: BaseViewModelDelegate {
    
}

protocol AccFlw5Stp3DeclareViewModelType: AnyObject {
    var coordinatorDelegate: AccFlw5Stp3DeclareVMCrdinatorDlgt? { get set }
    var delegate: AccFlw5Stp3DeclareViewModelDelegate? { get set }
    func getBack()
    func goToAccFlow5Step4()
    func goToGuide()
}

class AccFlw5Stp3DeclareViewModel: AccFlw5Stp3DeclareViewModelType {
    
    weak var coordinatorDelegate: AccFlw5Stp3DeclareVMCrdinatorDlgt?
    weak var delegate: AccFlw5Stp3DeclareViewModelDelegate?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func goToAccFlow5Step4() {
        coordinatorDelegate?.goToAccFlow5Step4()
    }
    
    func goToGuide() {
        coordinatorDelegate?.goToGuide()
    }
}
