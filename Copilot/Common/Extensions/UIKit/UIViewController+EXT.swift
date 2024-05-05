//
//  UIViewController+EXT.swift
//
//  Created by Jamal on 6/13/23.
//

import Foundation
import UIKit

extension UIViewController {
    
    func setBasicViews(addNotfication: Bool = true, addSearch: Bool = true) {
        setRedBackground()
        setHeader(addNotfication: addNotfication, addSearch: addSearch)
    }
    
    func setRedBackground() {
        view.backgroundColor = .secondRed
        let imageView = UIImageView()
        imageView.image = Images.backgroundPattern
        view.addSubview(imageView)
        imageView.align(top: 0, leading: 0, trailing: 14, height: 535)
        view.sendSubviewToBack(imageView)
    }
    
    func setHeader(addNotfication: Bool, addSearch: Bool) {
        let header = UIView()
        view.addSubview(header)
        let guide = view.safeAreaLayoutGuide
        header.topAnchor.constraint(equalTo: guide.topAnchor, constant: 16).isActive = true
        header.align(height: 44, leadingAndTrailing: 24)
        setLogo(to: header)
        if addNotfication {
            setNotificationView(to: header)
        }
        
        if addSearch {
            setSearchView(to: header)
        }
    }
    
    func setLogo(to header: UIView) {
        let imageView = UIImageView()
        imageView.image = Images.whiteLogo
        header.addSubview(imageView)
        imageView.align(top: 0, leading: 0, width: 76, height: 44)
    }
    
    func setNotificationView(to header: UIView) {
        let imageView = UIImageView()
        imageView.image = Images.notificationIcon
        header.addSubview(imageView)
        imageView.align(trailing: 0, widthAndHeight: 24, centerY: 0)
        let tap = UITapGestureRecognizer(target: self, action: #selector(goToNotifications))
        tap.numberOfTapsRequired = 1
        imageView.addGestureRecognizer(tap)
        imageView.isUserInteractionEnabled = true
    }
    
    func setSearchView(to header: UIView) {
        let imageView = UIImageView()
        imageView.image = Images.search
        header.addSubview(imageView)
        imageView.align(trailing: 48, widthAndHeight: 24, centerY: 0)
    }
    
    func hideTabbarView() {
        if let tabbar = self.tabBarController as? MainTabBarController {
            tabbar.tabBarView.isHidden = true
        }
    }
    
    func showTabbarView() {
        if let tabbar = self.tabBarController as? MainTabBarController {
            tabbar.tabBarView.isHidden = false
        }
    }
    
    func select(tab: Int) {
        if let tabbar = self.tabBarController as? MainTabBarController {
            tabbar.tabBarView.select(tab: tab)
        }
    }
    
    @objc func goToNotifications() {
        let controller: NotificationsViewController = UIStoryboard(storyboard: .notification).instantiateViewController()
        controller.viewModel = NotificationsViewModel()
        navigationController?.pushViewController(controller, animated: true)
    }
    
}

extension UINavigationController {
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

// MARK: Popups
extension UIViewController {
    //
    //    func presentAlert(title: String, message: String, compeletion: @escaping() -> Void = {}) {
    //
    //        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    //
    //        alert.addAction(UIAlertAction(title: Strings.okay, style: .destructive, handler: {_ in
    //            compeletion()
    //        }))
    //
    //        present(alert, animated: true, completion: nil)
    //    }
    
    //    func presentYesNoAlert(title: String, message: String, compeletion: @escaping() -> Void = {}) {
    //
    //        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    //
    //        alert.addAction(UIAlertAction(title: Strings.yes, style: .destructive, handler: {_ in
    //            compeletion()
    //        }))
    //
    //        alert.addAction(UIAlertAction(title: Strings.noText, style: .default, handler: {_ in
    //
    //        }))
    //
    //        present(alert, animated: true, completion: nil)
    //    }
    
    //    func showError(errorTitle: String = Strings.unSuccessful,
    //                   message: String = "",
    //                   buttonTitle: String = Strings.okay,
    //                   attributedMessage: NSAttributedString? = nil,
    //                   delegate: ErrorPopupViewControllerDelegate? = nil) {
    
    //        let viewController: ErrorPopupViewController = UIStoryboard(storyboard: .popup).instantiateViewController()
    //        viewController.titleText = errorTitle
    //        viewController.message = message
    //        viewController.buttonTitle = buttonTitle
    //        viewController.attributedMessage = attributedMessage
    //        viewController.delegate = delegate
    //        self.present(viewController, animated: true)
    //    }
    
    func showSuccess(successTitle: String,
                     message: String,
                     buttonTitle: String = Strings.okay,
                     attributedMessage: NSAttributedString? = nil,
                     delegate: MessagePopupViewControllerDelegate? = nil) {
        
        let viewController: SuccessPopupViewController = UIStoryboard(storyboard: .popup).instantiateViewController()
        viewController.titleText = successTitle
        viewController.message = message
        viewController.buttonTitle = buttonTitle
        viewController.attributedMessage = attributedMessage
        viewController.delegate = delegate
        self.present(viewController, animated: true)
    }
    
    func showSuccess(title: String, message: String) {
        showSuccess(successTitle: title, message: message)
    }
    
    func showSuccess(title: String, message: String, delegate: MessagePopupViewControllerDelegate? = nil) {
        showSuccess(successTitle: title, message: message, delegate: delegate)
    }
    
    func showError(errorTitle: String,
                   message: String,
                   buttonTitle: String = App.getString(key: "copilotapp.sign.up.success.button") ?? "",
                   attributedMessage: NSAttributedString? = nil,
                   delegate: MessagePopupViewControllerDelegate? = nil) {
        
        let viewController: SuccessPopupViewController = UIStoryboard(storyboard: .popup).instantiateViewController()
        viewController.titleText = errorTitle
        viewController.message = message
        viewController.buttonTitle = buttonTitle
        viewController.attributedMessage = attributedMessage
        viewController.color = .lightRed
        viewController.icon = Images.redCloseIcon
        viewController.delegate = delegate
        self.present(viewController, animated: true)
    }
    
    func showError(title: String, message: String) {
        showError(errorTitle: title, message: message)
    }
    
//    func showError(title: String, message: String, delegate: MessagePopupViewControllerDelegate? = nil) {
//        showError(errorTitle: title, message: message, delegate: delegate)
//    }
}
