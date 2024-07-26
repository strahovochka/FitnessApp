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
}
