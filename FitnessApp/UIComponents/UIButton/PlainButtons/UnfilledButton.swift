//
//  UnfilledButton.swift
//  FitnessApp
//
//  Created by Jane Strashok on 04.07.2024.
//

import UIKit

@IBDesignable
class UnfilledButton: PlainButton {
    
    override func config() {
        super.config()
        var buttonConfig = UIButton.Configuration.plain()
        buttonConfig.baseForegroundColor = .primaryYellow
        self.configuration = buttonConfig
    }
}
