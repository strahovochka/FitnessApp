//
//  UIImage+Extensions.swift
//  FitnessApp
//
//  Created by Jane Strashok on 04.07.2024.
//

import UIKit

extension UIImage {
    //Button images
    static let checkboxUnfilled = UIImage(named: "checkboxUnfilled")
    static let checkboxFilled = UIImage(named: "checkboxFilled")
    static let radioUnfilled = UIImage(named: "radioUnfilled")
    static let radioFilled = UIImage(named: "radioFilled")
    
    //Background image
    static let backgroundManFull = UIImage(named: "background")
    static let backgroundWomanFull = UIImage(named: "backgroundWomanFull")
    static let backgroundMan = UIImage(named: "backgroundMan")
    static let backgroundWoman = UIImage(named: "backgroundWoman")
    
    //TabBar images
    static let homeTab = UIImage(named: "homeTab")
    static let homeTabSelected = UIImage(named: "homeTabSelected")
    static let progressTab = UIImage(named: "progressTab")
    static let progressTabSelected = UIImage(named: "progressTabSelected")
    static let calculatorTab = UIImage(named: "calculatorTab")
    static let calculatorTabSelected = UIImage(named: "calculatorTabSelected")
    static let musclesTab = UIImage(named: "musclesTab")
    static let musclesTabSelected = UIImage(named: "musclesTabSelected")
    
    //Icons
    static let backIcon = UIImage(named: "backIcon")
    static let successIcon = UIImage(named: "successIcon")
    static let errorIcon = UIImage(named: "errorIcon")
    static let expandArrow = UIImage(named: "expandArrow")
    static let rightArrow = UIImage(named: "rightArrow")
    static let selectedFilled = UIImage(named: "selectedFilled")
    
    //Placeholders
    static let profileImage = UIImage(named: "profileImage")
    static let editProfile = UIImage(named: "editProfileImage")
    static let exerciseIcon = UIImage(named: "exerciseIcon")
}

extension UIImage {
    func getCompressedData(to kbCount: Int) -> Data? {
        let bytes = kbCount * 1024
        var compression: CGFloat = 1.0
        let step: CGFloat = 0.05
        if var data = self.jpegData(compressionQuality: compression) {
            while(data.count > bytes) {
                let ratio = CGFloat(data.count / bytes)
                compression -= step * ratio
                if let newData = self.jpegData(compressionQuality: compression) {
                    data = newData
                }
            }
            return data
        }
        return Data()
    }
}


