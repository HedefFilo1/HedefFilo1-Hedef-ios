//
//  MainViewModel.swift
//  Copilot
//
//  Created by Jamal on 10/9/23.
//

import Foundation
import UIKit

protocol MainViewModelCoordinatorDelegate: AnyObject {
    
}

protocol MainViewModelDelegate: AnyObject {
    
}

protocol MainViewModelType: AnyObject {
    
    var coordinatorDelegate: MainViewModelCoordinatorDelegate? { get set }
    var delegate: MainViewModelDelegate? { get set }
}

class MainViewModel: MainViewModelType {
   
    weak var coordinatorDelegate: MainViewModelCoordinatorDelegate?
    weak var delegate: MainViewModelDelegate?

}
