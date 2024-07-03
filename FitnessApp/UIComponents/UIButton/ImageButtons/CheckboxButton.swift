//
//  CheckboxButton.swift
//  FitnessApp
//
//  Created by Jane Strashok on 04.07.2024.
//

import UIKit

@IBDesignable
final class CheckboxButton: CustomImageButton {
    
    override func config() {
        self.filledImage = .checkboxFilled
        self.unfilledImage = .checkboxUnfilled
        super.config()
    }
}
