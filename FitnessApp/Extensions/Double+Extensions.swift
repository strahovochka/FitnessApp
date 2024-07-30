//
//  Double+Extensions.swift
//  FitnessApp
//
//  Created by Jane Strashok on 26.07.2024.
//

import Foundation

extension Double {
    func roundedString(to decimalPlaces: Int = 1) -> String {
        if self.truncatingRemainder(dividingBy: 1) == 0 {
            return String(format: "%.0f", self)
        } else {
            return String(format: "%.\(decimalPlaces)f", self)
        }
    }
}
