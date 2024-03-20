//
//  SupportGuideDetailViewModel.swift
//  Copilot
//
//  Created by Jamal on 3/20/24.
//

import Foundation

protocol SupportGuideDetailVMCrdinatorDlgt: AnyObject {
    func getBack()
}

protocol SupportGuideDetailViewModelDelegate: BaseViewModelDelegate {
    
}

protocol SupportGuideDetailViewModelType: AnyObject {
    var coordinatorDelegate: SupportGuideDetailVMCrdinatorDlgt? { get set }
    var delegate: SupportGuideDetailViewModelDelegate? { get set }
    var item: SupportGuide? { get set }
    func getBack()
}

class SupportGuideDetailViewModel: SupportGuideDetailViewModelType {
    weak var coordinatorDelegate: SupportGuideDetailVMCrdinatorDlgt?
    weak var delegate: SupportGuideDetailViewModelDelegate?
    var item: SupportGuide?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
 
}
