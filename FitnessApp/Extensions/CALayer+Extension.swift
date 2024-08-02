//
//  CALayer+Extension.swift
//  FitnessApp
//
//  Created by Jane Strashok on 02.08.2024.
//

import UIKit

extension CALayer {
    func fadeIn() {
        let alphaAnimation = CABasicAnimation(keyPath: "alpha")
        alphaAnimation.duration = 1.0
        alphaAnimation.fromValue = 0
        alphaAnimation.toValue = 1
        self.add(alphaAnimation, forKey: nil)
    }
}
