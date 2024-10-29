//
//  RequestListPageController.swift
//  Copilot
//
//  Created by Jamal on 10/28/24.
//

import Foundation
import UIKit

class RequestListPageController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    var pages = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        navigationItem.backButtonTitle = ""
        tabBarController?.tabBar.isHidden = true
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func setup() {
        dataSource = self
        delegate = self
        
        var firstIndex = 0
#if DEBUG
        firstIndex = 0
#endif
        setViewControllers([pages[firstIndex]], direction: .forward, animated: true)
    }
    
    func showPage1() {
        setViewControllers([pages[0]], direction: .reverse, animated: false)
    }
    
    func showPage2() {
        setViewControllers([pages[1]], direction: .forward, animated: false)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return nil
    }
}
