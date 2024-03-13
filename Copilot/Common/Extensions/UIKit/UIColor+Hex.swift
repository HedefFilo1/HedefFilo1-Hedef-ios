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
    
    /// #EA1C24
    static let secondRed = UIColor(named: "secondRed") ?? .red
    
    /// #ED1C24
    static let appRed = UIColor(named: "appRed") ?? .red
    
    /// #FFE8E9
    static let lightRed = UIColor(named: "lightRed") ?? .gray
    
    /// #EEEEEE
    static let exactGrey = UIColor(named: "exactGrey") ?? .gray
    
    /// #E1E1E1
    static let greyBorder = UIColor(named: "greyBorder") ?? .gray
    
    /// #58595B
    static let textGrey = UIColor(named: "textGrey") ?? .gray
    
    /// #D2D2D2
    static let appLightGrey = UIColor(named: "appLightGrey") ?? .gray
    
    /// #9E9EB0
    static let textLightGrey = UIColor(named: "textLightGrey") ?? .gray
    
    /// #EDEDF5
    static let borderColor = UIColor(named: "borderColor") ?? .gray
    
    /// #ECEDF2
    static let lightBorder = UIColor(named: "lightBorder") ?? .gray
    
    /// #9D99AC
    static let fieldsTitle = UIColor(named: "fieldsTitle") ?? .gray
    
    /// #F1F1F4
    static let whiteBorder = UIColor(named: "whiteBorder") ?? .gray
    
    /// #AAA
    static let fieldDescription = UIColor(named: "fieldDescription") ?? .gray
    
    /// #F2F2F2
    static let disabled = UIColor(named: "disabled") ?? .gray
    
    /// #CECECE
    static let textDisabled = UIColor(named: "textDisabled") ?? .gray
    
    /// #439F6E
    static let textSuccess = UIColor(named: "textSuccess") ?? .gray
    
    /// #25282B
    static let lightBlack = UIColor(named: "lightBlack") ?? .gray
    
    /// #212121
    static let fieldsText = UIColor(named: "fieldsText") ?? .black
    
    /// #FFF4DF
    static let lightYellow = UIColor(named: "lightYellow") ?? .black
    
    /// #FFB82E
    static let appYellow = UIColor(named: "appYellow") ?? .yellow
    
    /// #CACACA
    static let greyTextLight = UIColor(named: "greyTextLight") ?? .yellow
    
    /// #ACACAC
    static let textFieldGreyText = UIColor(named: "textFieldGreyText") ?? .yellow
    
    /// #C0ECD4
    static let lightGreen = UIColor(named: "lightGreen") ?? .yellow
    
    /// #5B6871
    static let dashedBorder = UIColor(named: "dashedBorder") ?? .yellow
    
    /// #F6F8F9
    static let lightGreyBackground = UIColor(named: "lightGreyBackground") ?? .yellow
    
    /// #9AA6AC
    static let greyButton = UIColor(named: "greyButton") ?? .yellow
    
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
