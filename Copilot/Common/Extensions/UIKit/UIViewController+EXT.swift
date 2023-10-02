//
//  UIViewController+EXT.swift
//  Nevita
//
//  Created by Jamal on 6/13/23.
//

import Foundation
import UIKit

extension UIViewController {
    
//    func setGradientBackground() {
//        view.backgroundColor = .clear
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.frame = self.view.bounds
//        gradientLayer.colors = [UIColor.theme.cgColor, UIColor.lightTheme.cgColor]
//        view.layer.insertSublayer(gradientLayer, at: 0)
//    }
//    
//    func setHeader(title: String, height: CGFloat = 68, addLogo: Bool = false) {
//        let header = UIView()
//        header.backgroundColor = .theme
//        view.addSubview(header)
//        let guide = view.safeAreaLayoutGuide
//        header.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
//        header.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
//        header.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
//        header.align(height: height)
//        header.layer.cornerRadius = 35
//        header.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
//        
//        setStatusBarBackground()
//        setTitleLabel(title: title, to: header)
//        if addLogo {
//            setLogo(to: header)
//            return
//        }
//        setBackButton(to: header)
//    }
    
//    func setStatusBarBackground() {
//        let guide = view.safeAreaLayoutGuide
//        let top = UIView()
//        top.backgroundColor = .theme
//        view.addSubview(top)
//        top.translatesAutoresizingMaskIntoConstraints = false
//        top.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//        top.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        top.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        top.bottomAnchor.constraint(equalTo: guide.topAnchor, constant: 1).isActive = true
//    }
//
//    func setTitleLabel(title: String, to header: UIView) {
//        let label = UILabel()
//        label.text = title
//        label.textColor = .white
//        label.textAlignment = .center
//        label.apply(TextStyle(fontStyle: .brandonMedium, size: 24), color: .white)
//        header.addSubview(label)
//        label.align(top: 13, leading: 48, trailing: 30)
//    }
//
//    func setLogo(to header: UIView) {
//        let imageView = UIImageView()
//        imageView.image = Images.logoSimple
//        header.addSubview(imageView)
//        imageView.align(top: 14, leading: 32, width: 31, height: 30)
//    }
    
//    func setBackButton(to header: UIView) {
//        let imageView = UIImageView()
//        imageView.image = Images.arrowBackIcon
//        header.addSubview(imageView)
//        imageView.align(top: 17, leading: 24, widthAndHeight: 24)
//
//        let backButton = UIButton()
//        header.addSubview(backButton)
//        backButton.align(toView: imageView, widthAndHeight: 40, centerX: 0, centerY: 0)
//        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
//    }
//
//    @objc func didTapBackButton() {
//        navigationController?.popViewController(animated: true)
//    }
//
//    func hideTabbarView() {
//        if let tabbar = self.tabBarController as? MainTabBarController {
//            tabbar.tabBarView.isHidden = true
//        }
//    }
//
//    func showTabbarView() {
//        if let tabbar = self.tabBarController as? MainTabBarController {
//            tabbar.tabBarView.isHidden = false
//        }
//    }
    
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

    func showError(title: String = "", message: String) {
//        showError(errorTitle: title, message: message)
    }

//    func showSuccess(successTitle: String = Strings.unSuccessful,
//                     message: String = "",
//                     buttonTitle: String = Strings.okay,
//                     attributedMessage: NSAttributedString? = nil,
//                     delegate: SuccessPopupViewControllerDelegate? = nil) {

//        let viewController: SuccessPopupViewController = UIStoryboard(storyboard: .popup).instantiateViewController()
//        viewController.titleText = successTitle
//        viewController.message = message
//        viewController.buttonTitle = buttonTitle
//        viewController.attributedMessage = attributedMessage
//        viewController.delegate = delegate
//        self.present(viewController, animated: true)
//    }

    func showSuccess(title: String = "", message: String) {
//        showSuccess(successTitle: title, message: message)
    }
}
