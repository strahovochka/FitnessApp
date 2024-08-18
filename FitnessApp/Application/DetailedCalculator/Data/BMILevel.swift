//
//  BMILevel.swift
//  FitnessApp
//
//  Created by Jane Strashok on 16.08.2024.
//

import Foundation

enum BMILevel: String, ResultLevel {
    case tooLow = "Severe weight deficiency"
    case low = "Underweight"
    case normal = "Norma"
    case high = "Overweight"
    case toHigh = "Obesity"
    case extremlyHigh = "Obesity is severe"
    case toExtremlyHigh = "Very severe obesity"
    case empty = "Enter the correct values"
    
    var description: String {
        self.rawValue
    }
    
    var isEmpty: Bool {
        self == BMILevel.empty
    }
    
    static func getLevel(from value: Double) -> BMILevel {
        switch value {
        case 0.01...16.0:
            return .tooLow
        case 16...18.5:
            return .low
        case 18.5...24.99:
            return .normal
        case 25...30:
            return .high
        case 30...35:
            return .toHigh
        case 35...40:
            return .extremlyHigh
        case 40...:
            return .toExtremlyHigh
        default:
            return .empty
        }
    }
}
