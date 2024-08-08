//
//  UIFont+Extension.swift
//  FitnessApp
//
//  Created by Jane Strashok on 04.07.2024.
//

import UIKit
import CoreText

extension UIFont {
    //Saira family
    static let regularSaira = UIFont(name: "SairaRoman-Regular", size: 16)
    static let thinSaira = UIFont(name: "Saira-Thin", size: 16)
    static let extraLightSaira = UIFont(name: "SairaRoman-ExtraLight", size: 16)
    static let lightSaira = UIFont(name: "SairaRoman-Light", size: 16)
    static let mediumSaira = UIFont(name: "SairaRoman-Medium", size: 16)
    static let semiboldSaira = UIFont(name: "SairaRoman-SemiBold", size: 16)
    static let boldSaira = UIFont(name: "SairaRoman-Bold", size: 16)
    static let extraBoldSaira = UIFont(name: "SairaRoman-ExtraBold", size: 16)
    //Futura family
    static let mediumFutura = UIFont(name: "Futura-Medium", size: 16)
    static let mediumItalicFutura = UIFont(name: "Futura-MediumItalic", size: 16)
    static let boldFutura = UIFont(name: "Futura-Bold", size: 16)
    static let condensedMediumFutura = UIFont(name: "Futura-CondensedMedium", size: 16)
    static let condensedExtraBoldFutura = UIFont(name: "Futura-CondensedExtraBold", size: 16)
    //Gilroy
    static let regularGilroy = UIFont(name: "Gilroy-Semibold", size: 16)
    //Nunito family
    static let regularNunito = UIFont(name: "Nunito-Regular", size: 16)
    static let extraLightNunito = UIFont(name: "Nunito-ExtraLight", size: 16)
    static let lightNunito = UIFont(name: "Nunito-Light", size: 16)
    static let mediumNunito = UIFont(name: "Nunito-Medium", size: 16)
    static let semiboldNunito = UIFont(name: "Nunito-SemiBold", size: 16)
    static let boldNunito = UIFont(name: "Nunito-Bold", size: 16)
    static let extraBoldNunito = UIFont(name: "Nunito-ExtraBold", size: 16)
}

extension UIFont {
    var cgFont: CGFont? {
        let ctFont = CTFontCreateWithName(self.fontName as NSString, self.pointSize, nil)
        return CTFontCopyGraphicsFont(ctFont, nil)
    }
}
