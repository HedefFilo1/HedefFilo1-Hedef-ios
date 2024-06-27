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
//        viewModel.start()
        
//        let button = UIButton(type: .roundedRect)
//            button.frame = CGRect(x: 20, y: 50, width: 100, height: 30)
//            button.setTitle("Test Crash", for: [])
//            button.addTarget(self, action: #selector(self.crashButtonTapped(_:)), for: .touchUpInside)
//            view.addSubview(button)
        
        navigationController?.navigationBar.isHidden = true
        viewModel.verifyToken()
    }
    
//    @IBAction func crashButtonTapped(_ sender: AnyObject) {
//         let numbers = [0]
//         let _ = numbers[1]
//     }

    func goToNextPage() {
        
    }
}

extension SplashViewController: SplashViewModelDelegate {
    
}
