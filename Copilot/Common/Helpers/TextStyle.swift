//
//  TextStyle.swift
//  Copilot
//
//  Created by Jamal on 9/28/23.
//

import Foundation
import UIKit

struct TextStyle {
    let fontStyle: FontStyle
    let size: CGFloat
    var font: UIFont {
        return fontStyle.asUIFont(size: size)
    }
}

enum FontWeighType  {
    case r400
    case m500
    case b700
    
    var style: FontStyle {
        switch self {
        case .r400:
            return .regular
        case .m500:
            return .medium
        case .b700:
            return .bold
        }
    }
}

enum FontTypographyType {
    
    case secondRed(FontWeighType, size: CGFloat)
    
    /// black size(20) Bold(700)
    case blackS20B700
    
    /// black size(18) Bold(700)
    case blackS18B700
    
    /// black size(16) Bold(700)
    case blackS16B700
    
    /// black size(16) Regular(400)
    case blackS16B400
    
    /// black size(15) Regular(400)
    case blackS15B400
    
    /// black size(16) Medium(500)
    case blackS16M500
    
    /// black size(12) Bold(700)
    case blackS12R700
    
    /// black size(12) Medium(500)
    case blackS12M500
    
    /// black size(12) Regular(400)
    case blackS12R400
    
    /// textGrey size(12) Regular(400)
    case greyS12R400
    
    /// textGrey size(16) Regular(400)
    case greyS16B400
    
    /// textGrey size(15) Regular(400)
    case greyS15B400
    
    /// textGrey size(12) Medium(500)
    case greyS12M500
    
    /// theme size(16) Bold(700)
    case themeS16B700
    
    /// theme size(20) Bold(700)
    case themeS20B700
    
    /// theme size(12) Regular(400)
    case themeS12R400
    
    /// whitesize(20) Bold(700)
    case whiteS20B700
    
    /// white size(16) Bold(700)
    case whiteS16B700
    
    /// white size(16) Regular(400)
    case whiteS16R400
    
    /// white size(12) Bold(700)
    case whiteS12B700

    var style: (TextStyle, UIColor) {
        switch self {
        
        case .secondRed(let weight, let size):
            return (TextStyle(fontStyle: weight.style, size: size), color: .secondRed)
            
        case .blackS20B700:
            return (TextStyle(fontStyle: .bold, size: 20), color: .black)
            
        case .blackS18B700:
            return (TextStyle(fontStyle: .bold, size: 18), color: .black)
            
        case .blackS16B700:
            return (TextStyle(fontStyle: .bold, size: 16), color: .black)
        
        case .blackS16B400:
            return (TextStyle(fontStyle: .regular, size: 16), color: .black)
            
        case .blackS15B400:
            return (TextStyle(fontStyle: .regular, size: 15), color: .black)
            
        case .blackS16M500:
            return (TextStyle(fontStyle: .medium, size: 16), color: .black)
        
        case .blackS12M500:
            return (TextStyle(fontStyle: .medium, size: 12), color: .black)
            
        case .blackS12R700:
            return (TextStyle(fontStyle: .bold, size: 12), color: .black)
            
        case .blackS12R400:
            return (TextStyle(fontStyle: .regular, size: 12), color: .black)
            
        case .greyS12R400:
            return (TextStyle(fontStyle: .regular, size: 12), color: .textGrey)
            
        case .greyS12M500:
            return (TextStyle(fontStyle: .medium, size: 12), color: .textGrey)
            
        case .greyS16B400:
            return (TextStyle(fontStyle: .regular, size: 16), color: .textGrey)
            
        case .greyS15B400:
            return (TextStyle(fontStyle: .regular, size: 15), color: .textGrey)
            
        case .themeS16B700:
            return (TextStyle(fontStyle: .bold, size: 16), color: .theme)
            
        case .themeS20B700:
            return (TextStyle(fontStyle: .bold, size: 20), color: .theme)
        
        case .themeS12R400:
            return (TextStyle(fontStyle: .regular, size: 12), color: .theme)
            
        case .whiteS20B700:
            return (TextStyle(fontStyle: .bold, size: 20), color: .white)
            
        case .whiteS16B700:
            return (TextStyle(fontStyle: .bold, size: 16), color: .white)
            
        case .whiteS16R400:
            return (TextStyle(fontStyle: .regular, size: 16), color: .white)
            
        case .whiteS12B700:
            return (TextStyle(fontStyle: .bold, size: 12), color: .white)
            
        }
    }
    
    var font: UIFont {
        return self.style.0.font
    }
}

enum FontStyle: String {
    
    /// weight: 700
    case bold = "DIN-Bold"
    
    /// weight: 500
    case medium = "DIN-Medium"
    
    /// weight: 400
    case regular = "DIN-Regular"

    func asUIFont(size: CGFloat) -> UIFont {
        return UIFont(name: self.rawValue, size: size)!
    }
}

extension UITextField {
    
    func apply(_ typo: FontTypographyType) {
        let style = typo.style
        apply(style.0, color: style.1)
    }
    
    func apply(_ textStyle: TextStyle, color: UIColor) {
        self.font = textStyle.fontStyle.asUIFont(size: textStyle.size)
        self.textColor = color
    }
    
    func setLeftPadding(_ amount: CGFloat = 10) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: bounds.size.height))
        leftView = paddingView
        leftViewMode = .always
    }
    
    func setRightPadding(_ amount: CGFloat = 10) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: bounds.size.height))
        rightView = paddingView
        rightViewMode = .always
    }
}

extension UITextView {
    
    func apply(_ typo: FontTypographyType) {
        let style = typo.style
        apply(style.0, color: style.1)
    }
    
    func apply(_ textStyle: TextStyle, color: UIColor) {
        self.font = textStyle.fontStyle.asUIFont(size: textStyle.size)
        self.textColor = color
    }
}

extension UILabel {
    
    func apply(_ typo: FontTypographyType) {
        let style = typo.style
        apply(style.0, color: style.1)
    }
    
    func apply(_ textStyle: TextStyle, color: UIColor) {
        self.font = textStyle.fontStyle.asUIFont(size: textStyle.size)
        self.textColor = color
    }
    
    func underline(_ textStyle: TextStyle, color: UIColor, underlineText: String) {
        guard let text = text else { return }
        let underlineAttriString = NSMutableAttributedString(string: text, attributes: [
            NSAttributedString.Key.font: textStyle.fontStyle.asUIFont(size: textStyle.size),
            NSAttributedString.Key.foregroundColor: color
        ])
        let termsRange = (text as NSString).range(of: underlineText)
        underlineAttriString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: termsRange)
        attributedText = underlineAttriString
    }
    
    /// Find the index of character (in the attributedText) at point
    func indexOfAttributedTextCharacterAtPoint(point: CGPoint) -> Int {
        assert(self.attributedText != nil, "This method is developed for attributed string")
        let textStorage = NSTextStorage(attributedString: self.attributedText!)
        let layoutManager = NSLayoutManager()
        textStorage.addLayoutManager(layoutManager)
        let textContainer = NSTextContainer(size: self.frame.size)
        textContainer.lineFragmentPadding = 0
        textContainer.maximumNumberOfLines = self.numberOfLines
        textContainer.lineBreakMode = self.lineBreakMode
        layoutManager.addTextContainer(textContainer)
        
        let index = layoutManager.characterIndex(for: point, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        return index
    }
}

extension UIButton {
    
    func apply(_ typo: FontTypographyType) {
        let style = typo.style
        apply(style.0, color: style.1)
    }
    
    func apply(_ textStyle: TextStyle, color: UIColor) {
        titleLabel?.font = textStyle.fontStyle.asUIFont(size: textStyle.size)
        
        let states: [UIControl.State] = [.normal, .highlighted, .selected, [.highlighted, .selected]]
        for state in states {
            self.setTitleColor(color, for: state)
        }
    }
}
