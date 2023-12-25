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
    
    let tabBarView = TabBarView()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func setup() {
        tabBar.isHidden = true
        setupTabBarView()
        moreNavigationController.isNavigationBarHidden = true
    }
    
    func setupTabBarView() {
        
        var bottomInset = App.window.safeAreaInsets.bottom
        if bottomInset == 0 {
            bottomInset = 8
        }
        let width = view.frame.width
        let height = 57 + bottomInset
        let yPoint = view.frame.height - height
        
        tabBarView.frame = CGRect(x: 0,
                                  y: yPoint,
                                  width: width,
                                  height: height)
        tabBarView.delegate = self
        view.addSubview(tabBarView)
    }
    
    func setSelectedIndex(index: Int) {
        if index > 4 {
            tabBarView.deselectLastIndex()
        }
        selectedIndex = index
    }
    
}

extension MainTabBarController: TabBarViewDelegate {
    
    func didSelect(tab: Int) {
        if tab == selectedIndex, let navigation = selectedViewController as? UINavigationController {
            navigation.popToRootViewController(animated: true)
            return
        }
        selectedIndex = tab
    }
}

extension MainTabBarController: MainViewModelDelegate {
    
}
