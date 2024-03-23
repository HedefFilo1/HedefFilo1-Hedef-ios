//
//  SheetViewController.swift
//  Copilot
//
//  Created by Jamal on 10/5/23.
//

import Foundation
import UIKit

class SheetViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    var presentationHeight: CGFloat {
        return 400
    }
    
    var initialPan: CGFloat = 0
    
    var prsentingFrame: CGRect {
        if let presentation = presentationController as? SheetPresentationController {
            return presentation.frameOfPresentedViewInContainerView
        }
        return .zero
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        modalPresentationStyle = .custom
        transitioningDelegate = self
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        modalPresentationStyle = .custom
        transitioningDelegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        SheetPresentationController(presentedViewController: presented, presenting: presenting)
    }
    
    func setup() {
//        view.backgroundColor = .clear
//        addBottomView()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(didDragView))
        view.addGestureRecognizer(panGesture)
    }
    
    func addBottomView() {
        let bottomView = UIView()
        view.addSubview(bottomView)
        bottomView.align(bottom: 0, leadingAndTrailing: 0)
        bottomView.backgroundColor = .white
        bottomView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive  = true
        view.sendSubviewToBack(bottomView)
    }
    
    @objc func didDragView(sender: UIPanGestureRecognizer) {
        let translationY = sender.translation(in: view).y
        
        if sender.state == .began {
            initialPan = view.frame.minY
            return
        }
        if translationY < 0 {
            return
        }
        view.frame.origin.y = initialPan + translationY
        
        if sender.state == .ended {
            if view.frame.origin.y > prsentingFrame.midY {
                dismiss(animated: true)
            } else {
                
                UIView.animate(withDuration: 0.3) { [unowned self] in
                    view.frame.origin.y = prsentingFrame.origin.y
                }
            }
        }
    }
}

class SheetPresentationController: UIPresentationController {
    
    var height: CGFloat {
        if let presentd = presentedViewController as? SheetViewController {
            return presentd.presentationHeight
        }
        return 400
    }
    
    let blurEffectView: UIVisualEffectView!
    var tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer()
    var dismissByTap: Bool {
        return false
    }
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        let blurEffect = UIBlurEffect(style: .dark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.blurEffectView.isUserInteractionEnabled = true
        
        if dismissByTap {
            tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissController))
            self.blurEffectView.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        var final = height + UIView().notchHeight
        let containerHeight = self.containerView?.frame.height ?? 0
        let containerWidth = self.containerView?.frame.width ?? 0
        if final > containerHeight {
            final = containerHeight
        }
        return CGRect(x: 0, y: containerHeight - final, width: containerWidth, height: final)
    }
    
    override func presentationTransitionWillBegin() {
        self.blurEffectView.alpha = 0
        self.containerView?.addSubview(blurEffectView)
        self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (_) in
            self.blurEffectView.alpha = 0.7
        }, completion: { (_) in })
    }
    
    override func dismissalTransitionWillBegin() {
        self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (_) in
            self.blurEffectView.alpha = 0
        }, completion: { (_) in
            self.blurEffectView.removeFromSuperview()
        })
    }
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        presentedView!.roundCorners([.topLeft, .topRight], radius: 24)
    }
    
    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        presentedView?.frame = frameOfPresentedViewInContainerView
        blurEffectView.frame = containerView!.bounds
    }
    
    @objc func dismissController() {
        self.presentedViewController.dismiss(animated: true, completion: nil)
    }
}
