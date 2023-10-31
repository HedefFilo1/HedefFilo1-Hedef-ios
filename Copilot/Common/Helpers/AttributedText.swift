//
//  AttributedText.swift
//  Copilot
//
//  Created by Jamal on 10/5/23.
//

import Foundation
import UIKit

struct AttributedText {
    
    let text: String
    var fontSize: CGFloat = 12
    var style: FontStyle = .regular
    var textColor: UIColor = .black
    
    init(text: String, fontSize: CGFloat, style: FontStyle, textColor: UIColor) {
        self.text = text
        self.fontSize = fontSize
        self.style = style
        self.textColor = textColor
    }
    
    init(text: String, type: FontTypographyType) {
        self.text = text
        fontSize = type.style.0.size
        style = type.style.0.fontStyle
        textColor = type.style.1
    }
    
    static func createString(texts: [AttributedText]) -> NSMutableAttributedString {
        
        let attr: NSMutableAttributedString = NSMutableAttributedString(string: "")
        
        for item in texts {
            let regular = NSMutableAttributedString(string: item.text, attributes: [
                .foregroundColor: item.textColor,
                .font: TextStyle(fontStyle: item.style, size: item.fontSize).font])
            attr.append(regular)
        }
        
        return attr
    }
    
    //    static func createBoldPartText(text: String, boldText: String, textColor: UIColor = .black, fontSize: CGFloat = 14) -> NSMutableAttributedString{
    //
    //        let attributedString = NSMutableAttributedString(string: "")
    //
    //        let boldAttributes: [NSAttributedString.Key: Any] = [
    //            .font: TextStyle(fontStyle: .brandonBold, size: fontSize).font,
    //            .foregroundColor: textColor
    //        ]
    //
    //        let attr1 = NSMutableAttributedString(string: text, attributes: [
    //            .font: TextStyle(fontStyle: .brandonRegular, size: fontSize).font,
    //            .foregroundColor: textColor
    //        ])
    //
    //        attributedString.append(attr1)
    //
    //        let string:NSString = NSString(string: text)
    //        let rangeForBold: NSRange = string.range(of: boldText)
    //        attributedString.addAttributes(boldAttributes,
    //                                       range: rangeForBold)
    //        return attributedString
    //    }
    
    static func createMultiplePartString(mainText: AttributedText, texts: [AttributedText]) -> NSMutableAttributedString {
        
        let attr: NSMutableAttributedString = NSMutableAttributedString(string: "")
        let attr1 = NSMutableAttributedString(string: mainText.text, attributes: [
            .font: TextStyle(fontStyle: mainText.style, size: mainText.fontSize).font,
            .foregroundColor: mainText.textColor
        ])
        
        attr.append(attr1)
        
        for item in texts {
            
            let itemAttrs: [NSAttributedString.Key: Any] = [
                .font: TextStyle(fontStyle: item.style, size: item.fontSize).font,
                .foregroundColor: item.textColor
            ]
            let string = NSString(string: mainText.text)
            let rangeOfItem: NSRange = string.range(of: item.text)
            attr.addAttributes(itemAttrs, range: rangeOfItem)
        }
        
        return attr
    }
    
    static func createUnderlinedString(mainText: AttributedText, underlinedText: AttributedText) -> NSMutableAttributedString {
        
        let attr: NSMutableAttributedString = NSMutableAttributedString(string: "")
        let attr1 = NSMutableAttributedString(string: mainText.text, attributes: [
            .font: TextStyle(fontStyle: mainText.style, size: mainText.fontSize).font,
            .foregroundColor: mainText.textColor
        ])
        
        attr.append(attr1)
        
        let itemAttrs: [NSAttributedString.Key: Any] = [
            .font: TextStyle(fontStyle: underlinedText.style, size: underlinedText.fontSize).font,
            .foregroundColor: underlinedText.textColor,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        
        let string = NSString(string: mainText.text)
        let rangeOfItem: NSRange = string.range(of: underlinedText.text)
        attr.addAttributes(itemAttrs, range: rangeOfItem)
        
        return attr
    }
}
