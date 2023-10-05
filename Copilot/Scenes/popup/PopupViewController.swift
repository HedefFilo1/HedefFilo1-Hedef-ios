//
//  PopupViewController.swift
//  Copilot
//
//  Created by Jamal on 10/5/23.
//

import Foundation
import UIKit

class PopupViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
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
        PopupPresentationController(presentedViewController: presented, presenting: presenting)
    }
    
    func setup() {
        view.backgroundColor = .clear
    }
}

class PopupPresentationController: SheetPresentationController {
    
    var height: CGFloat = 0
    
    override var dismissByTap: Bool {
        return false
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        presentedView?.layer.cornerRadius = 0
    }
}
