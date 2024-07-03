//
//  RadioButton.swift
//  FitnessApp
//
//  Created by Jane Strashok on 04.07.2024.
//

import Foundation

@IBDesignable
final class RadioButton: CustomImageButton {
    
    override func config() {
        self.unfilledImage = .radioUnfilled
        self.filledImage = .radioFilled
        super.config()
    }
}
