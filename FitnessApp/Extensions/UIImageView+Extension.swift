//
//  UIImageView+Extension.swift
//  FitnessApp
//
//  Created by Jane Strashok on 07.07.2024.
//

import UIKit

extension UIImageView {
    
    enum GradientDirection {
        case topToBottom
        case bottomToTop
    }

    func addGradient(frame: CGRect, direction: UIImageView.GradientDirection) {
        let gradientView = UIView(frame: self.frame)
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = frame
        gradientLayer.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        switch direction {
        case .topToBottom:
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 0.0, y: 1)
        case .bottomToTop:
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 1)
            gradientLayer.endPoint = CGPoint(x: 0.0, y: 0)
        }
        
        gradientView.layer.insertSublayer(gradientLayer, at: 0)
        addSubview(gradientView)
    }
    
    func addoverlay(color: UIColor = .black, alpha : CGFloat = 0.6) {
        let overlay = UIView()
        overlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        overlay.frame = bounds
        overlay.backgroundColor = color
        overlay.alpha = alpha
        addSubview(overlay)
    }
}

