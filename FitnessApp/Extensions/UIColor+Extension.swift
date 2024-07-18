//
//  UIColor+Extension.swift
//  FitnessApp
//
//  Created by Jane Strashok on 02.07.2024.
//

import UIKit

//-MARK: Colors of the app
extension UIColor {
    //Primary colors
    static let primaryRed = UIColor(hex: "#FF0000")
    static let primaryOrange = UIColor(hex: "#FA6969")
    static let primaryYellow = UIColor(hex: "#FFDB64")
    static let primaryGray = UIColor(hex: "#717171")
    static let primaryWhite = UIColor(hex: "#FFFFFF")
    static let primaryBlack = UIColor(hex: "#000000")
    //Secondary colors
    static let secondaryGray = UIColor(hex: "#BFBFBF")
}

//-MARK: Extension methods
extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        let i = 0
        let b = 2
        if i < b {
            var _ = i + b
        }
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
