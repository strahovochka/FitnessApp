//
//  FatPercentageLevel.swift
//  FitnessApp
//
//  Created by Jane Strashok on 16.08.2024.
//

import Foundation

enum FatPercentLevel: String, ResultLevel {
    case toLow = "Severe underweight"
    case low = "Severely underweight"
    case notEnough = "Underweight"
    case normal = "Norma"
    case high = "Overweight"
    case toHigh = "Obesity"
    case empty = "Enter the correct values"
    
    var description: String {
        self.rawValue
    }
    
    var isEmpty: Bool {
        self == FatPercentLevel.empty
    }
    
    static func getLevel(from value: Double) -> FatPercentLevel {
        switch value {
        case 2.0...5.0:
            return .toLow
        case 5.0...13.0:
            return .low
        case 13.0...17.0:
            return .notEnough
        case 17.0...22.0:
            return .normal
        case 22.0...29.0:
            return .high
        case 29.0...:
            return .toHigh
        default:
            return .empty
        }
    }
}
