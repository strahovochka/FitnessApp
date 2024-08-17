//
//  DetailedCalculatorViewModel.swift
//  FitnessApp
//
//  Created by Jane Strashok on 13.08.2024.
//

import Foundation

final class DetailedCalculatorViewModel: BaseViewModel<DetailedCalculatorCoordinator> {
    
    let navigationTitle = "Calculator"
    let calculateButtonText = "Calculate"
    let resultPlaceholderText = "Fill in your data"
    let activityButtonText = "Choose activity level".capitalized
    let caloriesDescriptionText = "Calories/day"
    
    let sex: Sex
    let type: CalculatorType
    let segmentItems = [Sex.male, Sex.female]
    private(set)var inputs: [InputType: Double] = [:]
    private(set) var activityLevel: DailyCaloriesRateAtivity = .empty {
        didSet {
            guard activityLevel != .empty else { return }
            self.updateActivityLevel(activityLevel)
        }
    }
    private(set) var result: (level: ResultLevel?, value: Double)? {
        didSet {
            self.updateResult()
        }
    }
    
    private(set) var selectedSegmentSex: Sex = .male {
        didSet {
            self.update()
        }
    }
    
    var update: () -> () = { }
    var updateActivityLevel: (DailyCaloriesRateAtivity?) -> () = {_ in }
    var updateResult: () -> () = { }
    
    init(sex: Sex, type: CalculatorType) {
        self.sex = sex
        self.type = type
        inputs = type.getInputs(for: .male).reduce(into: [:], { partialResult, input in
            partialResult[input] = 0.0
        })
    }
    
    func getSelectedInputs() -> [(input: InputType, value: Double)] {
        var result: [(InputType, Double)] = []
        type.getInputs(for: selectedSegmentSex).forEach { input in
            guard let value = inputs[input] else {
                result.append((input, 0.0))
                return
            }
            result.append((input, value))
        }
        return result
    }
    
    func updateSelectedSegment(with sex: Sex) {
        self.selectedSegmentSex = sex
    }
    
    func calculateResult() {
        let result: Double
        let level: ResultLevel?
        switch type {
        case .BMI:
            guard let height = inputs[.height],
                  let weight = inputs[.weight] else { return }
            result = Double(weight / ((height * height) / 10000))
            level = BMILevel.getLevel(from: result)
        case .fatPercentage:
            guard let waist = inputs[.waist],
                  let neck = inputs[.neck],
                  let height = inputs[.height] else { return }
            if selectedSegmentSex == .male {
                result = (495 / (1.0324 - 0.19077 * log10(waist - neck) + 0.15456 * log10(height))) - 450
            } else {
                guard let hips = inputs[.hips] else { return }
                result = (495 / (1.2958 - 0.35 * log10(waist + hips - neck) + 0.221 * log10(height))) - 450
            }
            level = FatPercentLevel.getLevel(from: result)
        case .dailyCalorieRequirement:
            let sexConstant = (selectedSegmentSex == .male) ? 5 : -161
            guard let weight = inputs[.weight],
                  let height = inputs[.height],
                  let age = inputs[.age],
                  activityLevel != .empty else { return }
            result = (10 * weight + 6.25 * height - 5 * Double(age) + Double(sexConstant)) * activityLevel.value
            level = nil
        }
        self.result = (level, result)
    }
    
    func goToActivityPopUp() {
        coordinator?.navigateToActivityPopUp(selectedActivityLevel: activityLevel, delegate: self)
    }
}

extension DetailedCalculatorViewModel: CustomTextFieldDelegate {
    func updateValue(_ textField: CustomTextField, for tag: Int, as newValue: String) {
        guard let inputType = InputType(rawValue: tag), let value = Double(newValue) else { return }
        inputs[inputType] = value
    }
}

extension DetailedCalculatorViewModel: ActivityLevelDelegate {
    func didSelectActivityLevel(_ level: DailyCaloriesRateAtivity?) {
        guard let level = level else { return }
        activityLevel = level
    }
}
