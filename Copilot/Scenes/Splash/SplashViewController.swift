//
//  SplashViewController.swift
//  Copilot
//
//  Created by Jamal on 9/27/23.
//

import Foundation
import UIKit

class SplashViewController: UIViewController {
    
    var viewModel: SplashViewModelType! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.start()
    }

    func goToNextPage() {
        
    }
}

extension SplashViewController: SplashViewModelDelegate {
    
}
