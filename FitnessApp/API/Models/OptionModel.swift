//
//  OptionModel.swift
//  FitnessApp
//
//  Created by Jane Strashok on 24.07.2024.
//

import Foundation

enum OptionDataName: String, Codable, CaseIterable {
    case height = "Height"
    case weight = "Weight"
    case neck = "Neck"
    case shoulders = "Shoulders"
    case leftBiceps = "Left biceps"
    case rightBiceps = "Right biceps"
    case leftThigh = "Left thigh"
    case rightThigh = "Right thigh"
    case rightForearm = "Right forearm"
    case leftForearm = "Left forearm"
    case chest = "Chest"
    case leftLowerLeg = "Left lower leg"
    case rightLowerLeg = "Right lower leg"
    case leftAnkle = "Left ankle"
    case rightAnkle = "Right ankle"

    var metricValue: String {
        switch self {
        case .weight:
            return "kg"
        default:
            return "cm"
        }
    }
    
    var maxValue: Double {
        switch self {
        case .height, .weight:
            return 300
        default:
            return 100
        }
    }
    
    var minValue: Double {
        switch self {
        case .height:
            return 60
        case .weight:
            return 20
        default:
            return 15
        }
    }
}

struct OptionModel: Codable, Hashable {
    var optionName: OptionDataName
    var valueArray: [Double?]
    var changedValue: Double?
    var dateArray: [Int]
    var isShown: Bool? = false
    
    func getChangedValue() -> Double? {
        guard valueArray.count >= 2 else { return nil }
        if let lastValue = valueArray.last ?? nil,
           let beforeLastValue = valueArray[valueArray.count - 2] {
            return lastValue - beforeLastValue
        } else {
            return nil
        }
    }
    
    func getChangedValue(for position: Int) -> Double? {
        guard (position < valueArray.count && position != 0) else { return nil }
        guard let value = valueArray[position], let previousValue = valueArray[position - 1] else { return nil }
        return value - previousValue
    }
    
    func getDictionary() -> [String: Any] {
        var data: [String: Any] = [:]
        data["optionName"] = optionName.rawValue
        data["valueArray"] = valueArray
        if let changedValue = changedValue {
            data["changedValue"] = changedValue
        }
        data["dateArray"] = dateArray
        if let isShown = isShown {
            data["isShown"] = isShown
        } else {
            data["isShown"] = true
        }
        return data
    }
}
