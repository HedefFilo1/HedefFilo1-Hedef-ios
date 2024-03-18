//
//  RequestDetailViewModel.swift
//  Copilot
//
//  Created by Jamal on 3/18/24.
//

import Foundation
protocol RequestDetailVMCrdntrDelegate: AnyObject {
    func getBack()
    func goToCanceledRequest(title: String)
}

protocol RequestDetailViewModelDelegate: BaseViewModelDelegate {

}

protocol RequestDetailViewModelType: AnyObject {
    var coordinatorDelegate: RequestDetailVMCrdntrDelegate? { get set }
    var delegate: RequestDetailViewModelDelegate? { get set }
    var title: String { get set }
    func getBack()
    func goToCanceledRequest()
}

class RequestDetailViewModel: RequestDetailViewModelType {
    
    weak var coordinatorDelegate: RequestDetailVMCrdntrDelegate?
    weak var delegate: RequestDetailViewModelDelegate?
    var title: String = "title"
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func goToCanceledRequest() {
        coordinatorDelegate?.goToCanceledRequest(title: title)
    }
}
