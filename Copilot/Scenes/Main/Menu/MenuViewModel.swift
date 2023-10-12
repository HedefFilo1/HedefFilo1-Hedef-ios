//
//  MenuViewModel.swift
//  Copilot
//
//  Created by Jamal on 10/12/23.
//

import Foundation
import UIKit

protocol MenuViewModelCoordinatorDelegate: AnyObject {
    func hideMenu()
}

protocol MenuViewModelDelegate: AnyObject {
    
}

protocol MenuViewModelType: AnyObject {
    
    var coordinatorDelegate: MenuViewModelCoordinatorDelegate? { get set }
    var delegate: MenuViewModelDelegate? { get set }
    func hideMenu()
}

class MenuViewModel: MenuViewModelType {
   
    weak var coordinatorDelegate: MenuViewModelCoordinatorDelegate?
    weak var delegate: MenuViewModelDelegate?
    
    func hideMenu() {
        coordinatorDelegate?.hideMenu()
    }
}
