//
//  DetailedCalculatorViewModel.swift
//  FitnessApp
//
//  Created by Jane Strashok on 13.08.2024.
//

import Foundation

protocol ResultLevel {
    var description: String { get }
}

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
    
    func getLevelDescription(from value: Double) -> ResultLevel {
        switch self {
        case .BDM:
            return BMILevel.getLevel(from: value)
        case .fatPercentage:
            return FatPercentLevel.getLevel(from: value)
        case .dailyCalorieRequirement:
            return FatPercentLevel.getLevel(from: value)
        }
    }
}

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

enum DailyCaloriesRateAtivity: String {
    case sitting = "sedentary lifestyle"
    case light = "light activity (1 to 3 times a week)"
    case middle = "medium activity (training 3-5 times a week)"
    case high = "high activity (training 6-7 times a week)"
    case extremal = "extremely high activity"
    
    var activityLevel: Double {
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

enum InputType: Int {
    case height
    case weight
    case neck
    case waist
    case hips
    case age
    
    var name: String {
        switch self {
        case .height:
            return "Height"
        case .weight:
            return "Weight"
        case .neck:
            return "Neck"
        case .waist:
            return "Waist"
        case .hips:
            return "Hips"
        case .age:
            return "Age"
        }
    }
    
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
    
    func createView() -> CalculatorInputView {
        let view = CalculatorInputView()
        view.config(with: self)
        return view
    }
}

final class DetailedCalculatorViewModel: BaseViewModel<DetailedCalculatorCoordinator> {
    let navigationTitle = "Calculator"
    let calculateButtonText = "Calculate"
    let resultPlaceholderText = "Fill in your data"
    let activityButtonText = "Choose activity level".capitalized
    
    let sex: Sex
    let type: CalculatorType
    var inputs: [Sex: [InputType: Double]]
    let segmentItems = [Sex.male, Sex.female]
    var activityLevel: DailyCaloriesRateAtivity? {
        didSet {
            guard let _ = activityLevel else { return }
            self.updateActivityLevel()
        }
    }
    var selectedSegmentSex: Sex = .male {
        didSet {
            self.update()
        }
    }
    
    var update: () -> () = { }
    var updateActivityLevel: () -> () = { }
    
    init(sex: Sex, type: CalculatorType) {
        self.sex = sex
        self.type = type
        self.inputs = [Sex.male, Sex.female].reduce(into: [:], { partialResult, sex in
            partialResult[sex] = type.getInputs(for: sex).reduce(into: [:], { partialResult, input in
                partialResult[input] = 0.0
            })
        })
    }
    
    func getSelectedInputs() -> [(InputType, Double)] {
        var result: [(InputType, Double)] = []
        type.getInputs(for: selectedSegmentSex).forEach { input in
            guard let value = inputs[selectedSegmentSex]?[input] else { return }
            result.append((input, value))
        }
        return result
    }
    
    func goToActivityPopUp() {
        coordinator?.navigateToActivityPopUp(selectedActivityLevel: activityLevel, delegate: self)
    }
}

extension DetailedCalculatorViewModel: CustomTextFieldDelegate {
    func updateValue(_ textField: CustomTextField, for tag: Int, as newValue: String) {
        guard let inputType = InputType(rawValue: tag), let value = Double(newValue) else { return }
        inputs[selectedSegmentSex]?[inputType] = value
    }
}

extension DetailedCalculatorViewModel: ActivityLevelDelegate {
    func didSelectActivityLevel(_ level: DailyCaloriesRateAtivity?) {
        activityLevel = level
    }
}
