//
//  InputType.swift
//  FitnessApp
//
//  Created by Jane Strashok on 16.08.2024.
//

import Foundation

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
