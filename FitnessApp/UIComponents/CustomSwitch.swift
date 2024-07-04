//
//  CustomSwitch.swift
//  FitnessApp
//
//  Created by Jane Strashok on 04.07.2024.
//

import UIKit

final class CustomSwitch: UISwitch {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialSetUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initialSetUp()
    }
    
    private func initialSetUp() {
        self.thumbTintColor = .primaryWhite
        self.onTintColor = .primaryYellow
        self.subviews[0].subviews[0].backgroundColor = .primaryGray
        for i in 0...1 {
            self.subviews[0].subviews[i].layer.borderWidth = 1
            self.subviews[0].subviews[i].layer.borderColor = UIColor.primaryWhite?.cgColor
        }
    }
}
