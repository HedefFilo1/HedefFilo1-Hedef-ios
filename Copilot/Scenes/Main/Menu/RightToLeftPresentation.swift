//
//  RightToLeftPresentation.swift
//  Copilot
//
//  Created by Jamal on 10/12/23.
//

import Foundation
import UIKit

class RightToLeftPresentation: SheetPresentationController {
    
    override var dismissByTap: Bool {
        return true
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        let containerHeight = self.containerView?.frame.height ?? 0
        let containerWidth = self.containerView?.frame.width ?? 0
        let width = containerWidth * 0.82
        let xpos = containerWidth - width
        return CGRect(x: xpos, y: 0, width: width, height: containerHeight)
    }
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        presentedView!.roundCorners([.topLeft, .topRight], radius: 0)
    }
}

class RightToLeftTransition: NSObject, UIViewControllerAnimatedTransitioning {
    let duration: TimeInterval = 0.25
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        let toView = transitionContext.view(forKey: .to)!
        
        container.addSubview(toView)
        toView.frame.origin = CGPoint(x: toView.frame.width, y: 0)
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: {
            toView.frame.origin = CGPoint(x: 0, y: 0)
        }, completion: { _ in
            transitionContext.completeTransition(true)
        })
    }
}

class LeftToRightTransition: NSObject, UIViewControllerAnimatedTransitioning {
    let duration: TimeInterval = 0.25
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        let fromView = transitionContext.view(forKey: .from)!
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: {
            fromView.frame.origin = CGPoint(x: container.frame.width, y: 0)
        }, completion: { _ in
            fromView.removeFromSuperview()
            transitionContext.completeTransition(true)
        })
    }
}
