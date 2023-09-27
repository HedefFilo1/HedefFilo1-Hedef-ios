//
//  UIView+EXT.swift
//  Nevita
//
//  Created by Jamal on 6/13/23.
//

import Foundation
import UIKit

extension UIView {
    // swiftlint:disable unused_setter_value
    var heightConstraint: NSLayoutConstraint? {
        get {
            return constraints.first(where: {
                $0.firstAttribute == .height && $0.relation == .equal
            })
        }
        set { setNeedsLayout() }
    }
    
    var widthConstraint: NSLayoutConstraint? {
        get {
            return constraints.first(where: {
                $0.firstAttribute == .width && $0.relation == .equal
            })
        }
        set { setNeedsLayout() }
    }
    // swiftlint:enable unused_setter_value
    
    var topConstraint: NSLayoutConstraint? {
        return self.constraints.filter({ ($0.firstItem as? UIView == self && $0.firstAttribute == .top) || ($0.secondItem as? UIView == self && $0.secondAttribute == .top) }).first
    }
    
    func boxShadow(xValue: CGFloat, yValue: CGFloat, radius: CGFloat, color: UIColor, opacity: Float) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = CGSize(width: xValue, height: yValue)
        layer.shadowRadius = radius
    }
}

extension UIView {
    
    func addSubviews(views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
    // swiftlint:disable cyclomatic_complexity
    func align(toView: UIView? = nil,
               top: CGFloat? = nil,
               leading: CGFloat? = nil,
               greaterThanOrEqualLeading: CGFloat? = nil,
               lessThanOrEqualLeading: CGFloat? = nil,
               trailing: CGFloat? = nil,
               greaterThanOrEqualTraling: CGFloat? = nil,
               lessThanOrEqualTraling: CGFloat? = nil,
               bottom: CGFloat? = nil,
               width: CGFloat? = nil,
               height: CGFloat? = nil,
               widthAndHeight: CGFloat? = nil,
               centerX: CGFloat? = nil,
               centerY: CGFloat? = nil,
               equalWidthRatio: CGFloat? = nil,
               equalHeightRatio: CGFloat? = nil,
               all: CGFloat? = nil,
               topAndBottom: CGFloat? = nil,
               leadingAndTrailing: CGFloat? = nil,
               topToBottom: CGFloat? = nil,
               leadingToTrailing: CGFloat? = nil,
               trailingToLeading: CGFloat? = nil,
               bottomToTop: CGFloat? = nil) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        var view = toView
        if toView == nil {
            view = self.superview
        }
        
        guard let view = view else { return }
        
        if let top = top {
            topAnchor.constraint(equalTo: view.topAnchor, constant: top).isActive = true
        }
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leading).isActive = true
        }
        
        if let greaterThanOrEqualLeading = greaterThanOrEqualLeading {
            leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: greaterThanOrEqualLeading).isActive = true
        }
        
        if let lessThanOrEqualLeading = lessThanOrEqualLeading {
            leadingAnchor.constraint(lessThanOrEqualTo: view.leadingAnchor, constant: lessThanOrEqualLeading).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -trailing).isActive = true
        }
        
        if let greaterThanOrEqualTraling = greaterThanOrEqualTraling {
            trailingAnchor.constraint(greaterThanOrEqualTo: view.trailingAnchor, constant: greaterThanOrEqualTraling).isActive = true
        }
        
        if let lessThanOrEqualTraling = lessThanOrEqualTraling {
            trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: lessThanOrEqualTraling).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -bottom).isActive = true
        }
        
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
        if let widthAndHeight = widthAndHeight {
            widthAnchor.constraint(equalToConstant: widthAndHeight).isActive = true
            heightAnchor.constraint(equalToConstant: widthAndHeight).isActive = true
        }
        
        if let centerX = centerX {
            centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: centerX).isActive = true
        }
        
        if let centerY = centerY {
            centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: centerY).isActive = true
        }
        
        if let equalWidthRatio = equalWidthRatio {
            widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: equalWidthRatio).isActive = true
        }
        
        if let equalHeightRatio = equalHeightRatio {
            heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: equalHeightRatio).isActive = true
        }
        
        if let all = all {
            align(toView: view, top: all, leading: all, trailing: all, bottom: all)
        }
        
        if let topAndBottom = topAndBottom {
            align(toView: view, top: topAndBottom, bottom: topAndBottom)
        }
        
        if let leadingAndTrailing = leadingAndTrailing {
            align(toView: view, leading: leadingAndTrailing, trailing: leadingAndTrailing)
        }
        
        if let topToBottom = topToBottom {
            topAnchor.constraint(equalTo: view.bottomAnchor, constant: topToBottom).isActive = true
        }
        
        if let leadingToTrailing = leadingToTrailing {
            leadingAnchor.constraint(equalTo: view.trailingAnchor, constant: leadingToTrailing).isActive = true
        }
        
        if let trailingToLeading = trailingToLeading {
            trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: trailingToLeading).isActive = true
        }
        
        if let bottomToTop = bottomToTop {
            bottomAnchor.constraint(equalTo: view.topAnchor, constant: bottomToTop).isActive = true
        }
    }
    // swiftlint:enable cyclomatic_complexity

    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
  
    func rotate(duration: CFTimeInterval = 1) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(Double.pi * 2)
        rotateAnimation.isRemovedOnCompletion = false
        rotateAnimation.duration = duration
        rotateAnimation.repeatCount = Float.infinity
        self.layer.add(rotateAnimation, forKey: nil)
    }
    
    func stopRotate() {
        self.layer.removeAllAnimations()
    }
    
    var hasNotch: Bool {
        let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        return bottom > 0
    }
    
    var notchHeight: CGFloat {
        let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        return bottom
    }
}

extension UITapGestureRecognizer {
    
    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {

        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)
        
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize
        
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        let textContainerOffset = CGPoint(
            x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,
            y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y
        )
        let locationOfTouchInTextContainer = CGPoint(
            x: locationOfTouchInLabel.x - textContainerOffset.x,
            y: locationOfTouchInLabel.y - textContainerOffset.y
        )
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
}
