//
//  UIColor+Hex.swift
//  PayCore
//
//  Created by Fikri Can Cankurtaran on 21.07.2022.
//

import Foundation
import UIKit.UIColor

extension UIColor {
    /// #E92127
    static let theme = UIColor(named: "theme") ?? .red
    
    /// #58595B
    static let textGrey = UIColor(named: "textGrey") ?? .gray
    
    /// #D2D2D2
    static let appLightGrey = UIColor(named: "appLightGrey") ?? .gray
    
    /// #ED1C24
    static let appRed = UIColor(named: "appRed") ?? .gray
    
    /// #EDEDF5
    static let borderColor = UIColor(named: "borderColor") ?? .gray
    
    /// #AAA
    static let fieldDescription = UIColor(named: "fieldDescription") ?? .gray
    
    /// #ECEDF2
    static let lightBorder = UIColor(named: "lightBorder") ?? .gray
    
    /// #F2F2F2
    static let disabled = UIColor(named: "disabled") ?? .gray
    
    /// #CECECE
    static let textDisabled = UIColor(named: "textDisabled") ?? .gray
    
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let alpha, red, green, blue: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (alpha, red, green, blue) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (alpha, red, green, blue) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (alpha, red, green, blue) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (alpha, red, green, blue) = (255, 0, 0, 0)
        }
        let redValue = CGFloat(red) / 255
        let greenValue = CGFloat(green) / 255
        let blueValue = CGFloat(blue) / 255
        self.init(red: redValue, green: greenValue, blue: blueValue, alpha: CGFloat(alpha) / 255)
    }

    var hexString: String {
        if let components = self.cgColor.components {
            let red = components[0]
            let green = components[1]
            let blue = components[2]
            return  String(format: "#%02x%02x%02x", (Int)(red * 255), (Int)(green * 255), (Int)(blue * 255))
        }
        return "#ffffff"
    }
}
