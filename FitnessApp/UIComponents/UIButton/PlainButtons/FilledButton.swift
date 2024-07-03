//
//  CustomButton.swift
//  FitnessApp
//
//  Created by Jane Strashok on 03.07.2024.
//

import UIKit

@IBDesignable
final class FilledButton: PlainButton {
    
    override func config() {
        super.config()
        var buttonConfig = UIButton.Configuration.filled()
        buttonConfig.cornerStyle = .capsule
        buttonConfig.baseBackgroundColor = .primaryYellow
        self.configuration = buttonConfig
        self.setTitleColor(.black, for: .normal)
    }
}
