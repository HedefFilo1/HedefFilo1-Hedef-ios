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
    var item: Task? { get set }
    func getBack()
    func goToCanceledRequest()
}

class RequestDetailViewModel: RequestDetailViewModelType {
    
    weak var coordinatorDelegate: RequestDetailVMCrdntrDelegate?
    weak var delegate: RequestDetailViewModelDelegate?
    var item: Task?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
    
    func goToCanceledRequest() {
        let title = item?.subject ?? ""
        coordinatorDelegate?.goToCanceledRequest(title: title)
    }
}
