//
//  DetailedCalculatorViewModel.swift
//  FitnessApp
//
//  Created by Jane Strashok on 13.08.2024.
//

import Foundation

final class DetailedCalculatorViewModel: BaseViewModel<DetailedCalculatorCoordinator> {
    
    struct SexData {
        private(set) var inputs: [InputType: Double]
        private(set) var result: Double? = nil
        private(set) var activityLevel: DailyCaloriesRateAtivity = .empty
        private(set) var BMIResult: BMILevel = .empty
        private(set) var fatResult: FatPercentLevel = .empty
        
        init(inputs: [InputType: Double]) {
            self.inputs = inputs
        }
        
        mutating func updateInput(_ input: InputType, with value: Double) {
            inputs[input] = value
        }
        
        mutating func updateResult(with value: Double?) {
            result = value
        }
        
        mutating func updateBMI(_ bmi: BMILevel) {
            self.BMIResult = bmi
        }
        
        mutating func updateFat(_ fatLevel: FatPercentLevel) {
            self.fatResult = fatLevel
        }
        
        mutating func updateActivityLevel(with level: DailyCaloriesRateAtivity) {
            activityLevel = level
        }
        
        func getOrderedInputs(for type: CalculatorType, and sex: Sex) -> [(InputType, Double)] {
            var result = [(InputType, Double)]()
            type.getInputs(for: sex).forEach { input in
                guard let value = inputs[input] else { return }
                result.append((input, value))
            }
            return result
        }
    }
    
    let navigationTitle = "Calculator"
    let calculateButtonText = "Calculate"
    let resultPlaceholderText = "Fill in your data"
    let activityButtonText = "Choose activity level".capitalized
    let caloriesDescriptionText = "Calories/day"
    
    let sex: Sex
    let type: CalculatorType
    let segmentItems = [Sex.male, Sex.female]
    private(set) var sexData: [Sex: SexData] = [:] {
        didSet {
            self.updateActivityLevel(sexData[selectedSegmentSex]?.activityLevel)
            guard let _ = sexData[selectedSegmentSex]?.result else { return }
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
        let inputs = [Sex.male, Sex.female].reduce(into: [:], { partialResult, sex in
            partialResult[sex] = type.getInputs(for: sex).reduce(into: [:], { partialResult, input in
                partialResult[input] = 0.0
            })
        })
        switch type {
        case .BMI:
            guard let maleInputs = inputs[.male] else { return }
            sexData[.male] = SexData(inputs: maleInputs)
        case .fatPercentage, .dailyCalorieRequirement:
            guard let maleInput = inputs[.male], let femaleInputs = inputs[.female] else { return }
            sexData[.male] = SexData(inputs: maleInput)
            sexData[.female] = SexData(inputs: femaleInputs)
        }
    }
    
    func getSelectedInputs() -> [(InputType, Double)] {
        guard let sexData = sexData[selectedSegmentSex] else { return [] }
        return sexData.getOrderedInputs(for: type, and: selectedSegmentSex)
    }
    
    func getActivityLevel() -> DailyCaloriesRateAtivity? {
        sexData[selectedSegmentSex]?.activityLevel
    }
    
    func getLevel() -> ResultLevel? {
        guard let sexData = sexData[selectedSegmentSex] else { return nil }
        switch type {
        case .BMI:
            return sexData.BMIResult
        case .fatPercentage:
            return sexData.fatResult
        case .dailyCalorieRequirement:
            return sexData.activityLevel
        }
    }
    
    func getCalculatedResult() -> Double? {
        sexData[selectedSegmentSex]?.result
    }
    
    func updateSelectedSegment(with sex: Sex) {
        self.selectedSegmentSex = sex
    }
    
    func calculateResult() {
        let result: Double
        let resultInputs = type.getInputs(for: selectedSegmentSex).reduce(into: [:]) { partialResult, input in
            partialResult[input] = sexData[selectedSegmentSex]?.inputs[input]
        }
        switch type {
        case .BMI:
            guard let height = resultInputs[.height], let weight = resultInputs[.weight] else { return }
            result = Double(weight / ((height * height) / 10000))
            sexData[selectedSegmentSex]?.updateBMI(BMILevel.getLevel(from: result))
        case .fatPercentage:
            guard let waist = resultInputs[.waist],
                  let neck = resultInputs[.neck],
                  let height = resultInputs[.height] else { return }
            if selectedSegmentSex == .male {
                result = (495 / (1.0324 - 0.19077 * log10(waist - neck) + 0.15456 * log10(height))) - 450
            } else {
                guard let hips = resultInputs[.hips] else { return }
                result = (495 / (1.2958 - 0.35 * log10(waist + hips - neck) + 0.221 * log10(height))) - 450
            }
            sexData[selectedSegmentSex]?.updateFat(FatPercentLevel.getLevel(from: result))
        case .dailyCalorieRequirement:
            let sexConstant = (selectedSegmentSex == .male) ? 5 : -161
            guard let weight = resultInputs[.weight],
                  let height = resultInputs[.height],
                  let age = resultInputs[.age],
                  let activityLevel = sexData[selectedSegmentSex]?.activityLevel.value else { return }
            result = (10 * weight + 6.25 * height - 5 * Double(age) + Double(sexConstant)) * activityLevel
        }
        sexData[selectedSegmentSex]?.updateResult(with: result)
    }
    
    func goToActivityPopUp() {
        coordinator?.navigateToActivityPopUp(selectedActivityLevel: sexData[selectedSegmentSex]?.activityLevel, delegate: self)
    }
}

extension DetailedCalculatorViewModel: CustomTextFieldDelegate {
    func updateValue(_ textField: CustomTextField, for tag: Int, as newValue: String) {
        guard let inputType = InputType(rawValue: tag), let value = Double(newValue) else { return }
        sexData[selectedSegmentSex]?.updateInput(inputType, with: value)
    }
}

extension DetailedCalculatorViewModel: ActivityLevelDelegate {
    func didSelectActivityLevel(_ level: DailyCaloriesRateAtivity?) {
        guard let activityLevel = level else {
            sexData[selectedSegmentSex]?.updateActivityLevel(with: .empty)
            return
        }
        sexData[selectedSegmentSex]?.updateActivityLevel(with: activityLevel)
    }
}
