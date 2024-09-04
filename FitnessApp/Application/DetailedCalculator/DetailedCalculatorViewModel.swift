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
            self.updateActivityLevel()
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
    var updateActivityLevel: () -> () = { }
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
        switch type {
        case .BMI:
            guard let bmi = calculateBMI() else { return }
            self.result = bmi
        case .fatPercentage:
            guard let fatPercentage = calculateFat() else { return }
            self.result = fatPercentage
        case .dailyCalorieRequirement:
            guard let calories = calculateCalories() else { return }
            self.result = (nil, calories)
        }
    }
    
    func goToActivityPopUp() {
        coordinator?.navigateToActivityPopUp(selectedActivityLevel: activityLevel, delegate: self)
    }
}

private extension DetailedCalculatorViewModel {
    func calculateBMI() -> (ResultLevel, Double)? {
        guard let height = inputs[.height],
              let weight = inputs[.weight] else { return nil }
        let result = Double(weight / ((height * height) / 10000))
        return(BMILevel.getLevel(from: result), result)
    }
    
    func calculateFat() -> (ResultLevel, Double)? {
        let result: Double
        guard let waist = inputs[.waist],
              let neck = inputs[.neck],
              let height = inputs[.height] else { return nil }
        if selectedSegmentSex == .male {
            result = (495 / (1.0324 - 0.19077 * log10(waist - neck) + 0.15456 * log10(height))) - 450
        } else {
            guard let hips = inputs[.hips] else { return nil }
            result = (495 / (1.2958 - 0.35 * log10(waist + hips - neck) + 0.221 * log10(height))) - 450
        }
        return (FatPercentLevel.getLevel(from: result), result)
    }
    
    func calculateCalories() -> Double? {
        let sexConstant = (selectedSegmentSex == .male) ? 5 : -161
        guard let weight = inputs[.weight],
              let height = inputs[.height],
              let age = inputs[.age],
              activityLevel != .empty else { return nil }
        let result = (10 * weight + 6.25 * height - 5 * Double(age) + Double(sexConstant)) * activityLevel.value
        return result
    }
}

extension DetailedCalculatorViewModel: CustomTextFieldDelegate {
    func updateValue(_ textField: CustomTextField, for tag: Int, as newValue: String) {
        guard let inputType = InputType(rawValue: tag) else { return }
        guard let value = Double(newValue) else {
            if newValue == "" {
                inputs[inputType] = 0.0
            }
            return
        }
        inputs[inputType] = value
    }
}

extension DetailedCalculatorViewModel: ActivityLevelDelegate {
    func didSelectActivityLevel(_ level: DailyCaloriesRateAtivity?) {
        guard let level = level else { return }
        activityLevel = level
    }
}
