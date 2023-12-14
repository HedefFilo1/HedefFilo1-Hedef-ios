//
//  Loading.swift
//  Copilot
//
//  Created by Jamal on 10/19/23.
//

import Foundation
import UIKit

class Loading {
    
    public static let shared = Loading()
    
    private let containerView = UIView()
    private let animationView = UIImageView()
    private let label = UILabel()
    
    var title: String = "" {
        didSet {
            label.text = title
        }
    }
    
    var message: String = "" {
        didSet {
            label.text = title + "\n\(message)"
        }
    }
    
    func show(presented: Bool = false, title: String = Strings.loading, presentingView: UIView? = nil) {
        guard let window = App.window else { return }
        
        animationView.image = Images.loadingSpinner.withRenderingMode(.alwaysTemplate)
        animationView.tintColor = .theme
        containerView.frame = window.frame
        containerView.center = window.center
        containerView.backgroundColor = .darkText.withAlphaComponent(0.7)
        
        animationView.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        animationView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        animationView.backgroundColor = .clear
        
        self.title = title
        label.text = title
        
        label.textAlignment = .center
        label.numberOfLines = 0
        label.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 80, height: 182)
        label.apply(TextStyle(fontStyle: .regular, size: 14), color: .darkText)
        containerView.addSubview(label)
        containerView.addSubview(animationView)
     
        if let presentingView = presentingView {
            presentingView.addSubview(containerView)
        } else
        if presented {
            window.addSubview(containerView)
            
        } else if let viewController = getCurrentController(window: window) {
            viewController.view.addSubview(containerView)
        } else {
            window.rootViewController?.view.addSubview(containerView)
        }
        
        if let superview = containerView.superview {
            containerView.frame = superview.frame
            containerView.center = superview.center
        }
        
        animationView.center = CGPoint(x: containerView.bounds.width / 2,
                                       y: containerView.bounds.height / 2)
        label.center = CGPoint(x: animationView.center.x, y: animationView.center.y + 54)
        
        animationView.rotate()

    }
    
    func hide() {
        animationView.removeFromSuperview()
        containerView.removeFromSuperview()
    }
    
    private func getCurrentController(window: UIWindow) -> UIViewController? {
        if let nav = window.rootViewController as? UINavigationController,
           let viewController = nav.topViewController {
//            let top = nav.topViewController
            if let tabbar = viewController as? UITabBarController {
                if let selected = tabbar.selectedViewController as? UINavigationController,
                   let current = selected.visibleViewController {
                    return current
                }
                if let nav = tabbar.selectedViewController as? UINavigationController {
                    return nav.topViewController
                }
                return tabbar.selectedViewController
            }
            
            return viewController
        }
        
        return nil
    }
}
