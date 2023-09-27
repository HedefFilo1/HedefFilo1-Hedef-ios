//
//  UIColor+Hex.swift
//  PayCore
//
//  Created by Fikri Can Cankurtaran on 21.07.2022.
//

import Foundation
import UIKit.UIColor

extension UIColor {
    /// #222F60
    static let theme = UIColor(named: "theme") ?? .blue
    
    /// #224D7B
    static let lightTheme = UIColor(named: "lightTheme") ?? .blue
    
    /// #58595B
    static let lightBodyText = UIColor(named: "lightBodyText") ?? .gray
    
    /// #808080
    static let lightGrayText = UIColor(named: "lightGrayText") ?? .gray
    
    /// #737373
    static let grey500 = UIColor(named: "grey500") ?? .gray
    
    /// #A3A3A3
    static let grey400 = UIColor(named: "grey400") ?? .gray
    
    /// #D6D6D6
    static let grey300 = UIColor(named: "grey300") ?? .gray
    
    /// #D2D2D2
    static let lightGrayBackground = UIColor(named: "lightGrayBackground") ?? .gray
    
    /// #E4E9F2
    static let modernBlue50 = UIColor(named: "modernBlue50") ?? .gray
    
    /// #EEF3F7
    static let lightGrayBorder = UIColor(named: "lightGrayBorder") ?? .gray
    
    /// #222222
    static let blackText = UIColor(named: "blackText") ?? .gray
    
    /// #101426
    static let simpleText = UIColor(named: "simpleText") ?? .gray
    
    /// #000000
    static let black = UIColor(named: "black") ?? .black
    
    /// #E4F1FF
    static let primaryBlue50 = UIColor(named: "primaryBlue50") ?? .blue
    
    /// #4E8FFF
    static let primaryBlue500 = UIColor(named: "primaryBlue500") ?? .blue
    
    /// #4F80FB
    static let primaryBlue600 =  UIColor(named: "mainBlue") ?? .mainBlue
    
    /// #4F80FB
    static let mainBlue = UIColor(named: "mainBlue") ?? .gray
    
    /// #8F9BB3
    static let shadow = UIColor(named: "shadow") ?? .gray
    
    /// #E8EBF2
    static let primary50 = UIColor(named: "primary50") ?? .gray
    
    /// #A0ADCB
    static let primary200 = UIColor(named: "primary200") ?? .blue
    
    /// #5F73A7
    static let primary400 = UIColor(named: "primary400") ?? .blue
    
    /// #222F60
    static let primary900 = UIColor(named: "primary900") ?? .gray
    
    /// #FBFCFD
    static let pageBackground = UIColor(named: "pageBackground") ?? .white
    
    /// #05D988
    static let success300 = UIColor(named: "success300") ?? .green
    
    /// #E0F9EB
    static let success50 = UIColor(named: "success50") ?? .green
    
    /// #FFF8E0
    static let warning50 = UIColor(named: "warning50") ?? .yellow
    
    /// #FDD348
    static let warning300 = UIColor(named: "warning300") ?? .yellow
    
    /// #FFE9F0
    static let error50 = UIColor(named: "error50") ?? .green
    
    /// ##FFC7D6
    static let error100 = UIColor(named: "error100") ?? .green
    
    /// #FC5977
    static let error300 = UIColor(named: "error300") ?? .green
    
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
