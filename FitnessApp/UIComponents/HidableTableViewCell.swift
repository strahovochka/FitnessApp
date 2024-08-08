//
//  HidableTableViewCell.swift
//  FitnessApp
//
//  Created by Jane Strashok on 08.08.2024.
//

import UIKit

class HidableTableViewCell: UITableViewCell {
    func maskCellFromTop(_ margin: CGFloat) {
        self.layer.mask = visibilityMask(withLocation: margin / self.frame.size.height)
        self.layer.masksToBounds = true
    }
        
    private func visibilityMask(withLocation location: CGFloat) -> CAGradientLayer {
        let mask = CAGradientLayer()
        mask.frame = self.bounds
        mask.colors = [UIColor(white: 1, alpha: 0).cgColor, UIColor(white: 1, alpha: 1).cgColor]
        mask.locations = [NSNumber(value: Float(location)), NSNumber(value: Float(location))]
        return mask
    }
}
