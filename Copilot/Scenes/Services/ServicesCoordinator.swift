//
//  ServicesCoordinator.swift
//  Copilot
//
//  Created by Jamal on 12/19/23.
//

import Foundation
import UIKit

protocol ServicesCoordinatorDelegate: AnyObject {
    func didFinish(from coordinator: Coordinator)
}

class ServicesCoordinator: Coordinator {
    
    let navigationController: UINavigationController
    let storyboard = UIStoryboard(storyboard: .services)
    weak var delegate: ServicesCoordinatorDelegate?
    
    init(with navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() {
        
    }
    
    override func finish() {
        delegate?.didFinish(from: self)
    }
}

extension ServicesCoordinator {
    
}
