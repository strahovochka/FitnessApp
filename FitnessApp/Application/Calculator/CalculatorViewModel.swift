//
//  CalculatorViewModel.swift
//  FitnessApp
//
//  Created by Jane Strashok on 07.07.2024.
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
}

final class CalculatorViewModel: UserDependentViewModel<CalculatorCoordinator> {
    
    let navigationTitle = "Calculator"
    let cells: [CalculatorType] = CalculatorType.allCases
    let rowHeight: CGFloat = 57
    
}
