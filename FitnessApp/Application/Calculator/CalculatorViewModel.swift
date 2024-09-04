//
//  CalculatorViewModel.swift
//  FitnessApp
//
//  Created by Jane Strashok on 07.07.2024.
//

import Foundation

final class CalculatorViewModel: UserDependentViewModel<CalculatorCoordinator> {
    
    let navigationTitle = "Calculator"
    let cells: [CalculatorType] = CalculatorType.allCases
    let rowHeight: CGFloat = 57
    
    func goToCalcuator(_ type: CalculatorType) {
        guard let user = user else { return }
        coordinator?.navigateToCalculator(type, user.getSex())
    }
}
