//
//  UnfilledAlertButton.swift
//  FitnessApp
//
//  Created by Jane Strashok on 04.07.2024.
//

import UIKit

@IBDesignable
final class UnfilledAlertButton: UnfilledButton {
    
    override func config() {
        super.config()
        self.configuration?.baseForegroundColor = .primaryOrange
    }
}
