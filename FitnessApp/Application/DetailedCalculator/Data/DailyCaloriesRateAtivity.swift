//
//  DailyCaloriesRateAtivity.swift
//  FitnessApp
//
//  Created by Jane Strashok on 16.08.2024.
//

import Foundation

enum DailyCaloriesRateAtivity: String, ResultLevel {
    case sitting = "sedentary lifestyle"
    case light = "light activity (1 to 3 times a week)"
    case middle = "medium activity (training 3-5 times a week)"
    case high = "high activity (training 6-7 times a week)"
    case extremal = "extremely high activity"
    case empty = "Enter the correct values"
    
    var description: String {
        "Calories/day"
    }
    
    var isEmpty: Bool {
        self == .empty
    }
    
    var value: Double {
        switch self {
        case .sitting:
            return 1.2
        case .light:
            return 1.38
        case .middle:
            return 1.56
        case .high:
            return 1.73
        case .extremal:
            return 1.95
        default:
            return 0.0
        }
    }
    
    var shortDescription: String {
        guard let startIndex = self.rawValue.firstIndex(of: "("), let endIndex = self.rawValue.lastIndex(of: ")") else { return self.rawValue }
        let range = startIndex...endIndex
        return self.rawValue.replacingCharacters(in: range, with: "")
    }
    
    static var allCases: [DailyCaloriesRateAtivity] {
        [.sitting, .light, .middle, .high, .extremal]
    }
}
