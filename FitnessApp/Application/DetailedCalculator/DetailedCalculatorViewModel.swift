//
//  DetailedCalculatorViewModel.swift
//  FitnessApp
//
//  Created by Jane Strashok on 13.08.2024.
//

import Foundation

enum CalculatorType: CaseIterable {
    case BDM
    case fatPercentage
    case dailyCalorieRequirement
    
    var name: String {
        switch self {
        case .BDM:
            return "Body Mass Index"
        case .fatPercentage:
            return "Fat Percentage"
        case .dailyCalorieRequirement:
            return "Daily Calorie Requirement"
        }
    }
    
    
    func getInputs(for sex: Sex) -> [InputType] {
        switch self {
        case .BDM:
            return [.height, .weight]
        case .fatPercentage:
            switch sex {
            case .male:
                return [.height, .neck, .waist]
            case .female:
                return [.height, .neck, .waist, .hips]
            }
        case .dailyCalorieRequirement:
            return [.height, .neck, .age]
        }
    }
}

enum InputType: String {
    case height
    case weight
    case neck
    case waist
    case hips
    case age
    
    var metricVale: String {
        switch self {
        case .height, .neck, .waist, .hips:
            return "cm"
        case .weight:
            return "kg"
        case .age:
            return "years"
        }
    }
}

final class DetailedCalculatorViewModel: BaseViewModel<DetailedCalculatorCoordinator> {
    let sex: Sex
    let type: CalculatorType
    let navigationTitle = "Calculator"
    let inputs: [InputType]
    let calculateButtonText = "Calculate"
    let resultPlaceholderText = "Fill in your data"
    
    init(sex: Sex, type: CalculatorType) {
        self.sex = sex
        self.type = type
        self.inputs = type.getInputs(for: .male)
    }
}
