//
//  UIImageView+Extension.swift
//  FitnessApp
//
//  Created by Jane Strashok on 07.07.2024.
//

import UIKit

extension UIView {
    
    private func createGradientLayer(_ colors: [UIColor], locations: [NSNumber], frame: CGRect = .zero) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors.map({ $0.cgColor })
        gradientLayer.locations = locations
        gradientLayer.frame = self.bounds
        return gradientLayer
    }
    
    func addGradient(_ colors: [UIColor], locations: [NSNumber], frame: CGRect = .zero, type: CAGradientLayerType = .axial) {
        let gradientLayer = createGradientLayer(colors, locations: locations, frame: frame)
        gradientLayer.type = type
        switch type {
        case .axial:
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        case .radial:
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        case .conic:
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 0)
        default:
            break;
        }
        self.layer.addSublayer(gradientLayer)
    }
    
    func addoverlay(color: UIColor = .primaryBlack, alpha : CGFloat = 0.6) {
        let overlay = UIView()
        overlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        overlay.frame = bounds
        overlay.backgroundColor = color
        overlay.alpha = alpha
        addSubview(overlay)
    }
    
    func animateRotation(by angle: CGFloat, duration: CFTimeInterval = 0.2) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.toValue = angle
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        self.layer.add(animation, forKey: "transform.rotation")
    }
}

