//
//  CalculatorType.swift
//  FitnessApp
//
//  Created by Jane Strashok on 16.08.2024.
//

import Foundation

protocol ResultLevel {
    var description: String { get }
    var isEmpty: Bool { get }
}

enum CalculatorType: CaseIterable {
    case BMI
    case fatPercentage
    case dailyCalorieRequirement
    
    var name: String {
        switch self {
        case .BMI:
            return "Body Mass Index"
        case .fatPercentage:
            return "Fat Percentage"
        case .dailyCalorieRequirement:
            return "Daily Calorie Requirement"
        }
    }
    
    
    func getInputs(for sex: Sex) -> [InputType] {
        switch self {
        case .BMI:
            return [.height, .weight]
        case .fatPercentage:
            switch sex {
            case .male:
                return [.height, .neck, .waist]
            case .female:
                return [.height, .neck, .waist, .hips]
            }
        case .dailyCalorieRequirement:
            return [.height, .weight, .age]
        }
    }
}
