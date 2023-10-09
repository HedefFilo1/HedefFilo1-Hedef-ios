//
//  MainTabBarController.swift
//  Copilot
//
//  Created by Jamal on 10/9/23.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController {
    
    var viewModel: MainViewModelType! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBarView()
    }
    
    func setupTabBarView() {
        tabBar.backgroundColor = .white
        tabBar.boxShadow(xValue: 0, yValue: -15, radius: 25, color: .black, opacity: 0.05)

        tabBar.layer.cornerRadius = 27
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tabBar.tintColor = .theme
        tabBar.unselectedItemTintColor = .textGrey
        
        let font = FontTypographyType.themeS12R400.font
        UITabBarItem.appearance().setTitleTextAttributes([.font: font], for: .normal)
    }

}

extension MainTabBarController: MainViewModelDelegate {
    
}
