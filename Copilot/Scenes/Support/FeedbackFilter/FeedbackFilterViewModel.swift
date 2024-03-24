//
//  FeedbackFilterViewModel.swift
//  Copilot
//
//  Created by Jamal on 3/24/24.
//

import Foundation

struct FeedbackFilterItem {
    let title: String
}

protocol FeedbackFilterVMCoordinatorDelegate: AnyObject {
    
}

protocol FeedbackFilterViewModelDelegate: AnyObject {
    
}

protocol FeedbackFilterViewModelType: AnyObject {
    var coordinatorDelegate: FeedbackFilterVMCoordinatorDelegate? { get set }
    var delegate: FeedbackFilterViewModelDelegate? { get set }
    var items: [FeedbackFilterItem] { get set }
    var selectedItem: FeedbackFilterItem? { get set }
    var title: String { get set }
}

class FeedbackFilterViewModel: FeedbackFilterViewModelType {
    
    weak var coordinatorDelegate: FeedbackFilterVMCoordinatorDelegate?
    weak var delegate: FeedbackFilterViewModelDelegate?
   
    var items: [FeedbackFilterItem] = []
    var selectedItem: FeedbackFilterItem?
    var title: String = ""

}
