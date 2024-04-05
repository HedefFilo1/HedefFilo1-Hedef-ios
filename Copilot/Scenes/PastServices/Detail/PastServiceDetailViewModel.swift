//
//  PastServiceDetailViewModel.swift
//  Copilot
//
//  Created by Jamal on 4/5/24.
//

import Foundation

protocol PastServiceDetailVMCoordinatorDelegate: AnyObject {
    func getBack()
}

protocol PastServiceDetailViewModelDelegate: AnyObject {
    
}

protocol PastServiceDetailViewModelType: AnyObject {
    var coordinatorDelegate: PastServiceDetailVMCoordinatorDelegate? { get set }
    var delegate: PastServiceDetailViewModelDelegate? { get set }
    func getBack()
    var title: String { get set }
    var service: PastService? { get set }
}

class PastServiceDetailViewModel: PastServiceDetailViewModelType {
    
    weak var coordinatorDelegate: PastServiceDetailVMCoordinatorDelegate?
    weak var delegate: PastServiceDetailViewModelDelegate?
    var title: String = Strings.care
    var service: PastService?
    
    func getBack() {
        coordinatorDelegate?.getBack()
    }
}
