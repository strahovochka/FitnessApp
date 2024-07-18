//
//  UIImageView+Extension.swift
//  FitnessApp
//
//  Created by Jane Strashok on 07.07.2024.
//

import UIKit

extension UIView {
    
    func addGradient(_ colors: [UIColor], locations: [NSNumber], frame: CGRect = .zero) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors.map({ $0.cgColor })
        gradientLayer.locations = locations
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.frame = self.bounds
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func addoverlay(color: UIColor = .primaryBlack, alpha : CGFloat = 0.6) {
        let overlay = UIView()
        overlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        overlay.frame = bounds
        overlay.backgroundColor = color
        overlay.alpha = alpha
        addSubview(overlay)
    }
}

