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
    let sex: Sex
    let type: CalculatorType
    let navigationTitle = "Calculator"
    var inputs: [Sex: [InputType: Double]]
    let calculateButtonText = "Calculate"
    let resultPlaceholderText = "Fill in your data"
    let segmentItems = [Sex.male, Sex.female]
    var selectedSegmentSex: Sex = .male {
        didSet {
            self.update()
        }
    }
    
    var update: () -> () = { }
    
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
}

extension DetailedCalculatorViewModel: CustomTextFieldDelegate {
    func updateValue(_ textField: CustomTextField, for tag: Int, as newValue: String) {
        guard let inputType = InputType(rawValue: tag), let value = Double(newValue) else { return }
        inputs[selectedSegmentSex]?[inputType] = value
    }
}
