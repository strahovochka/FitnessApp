//
//  Int+Extension.swift
//  FitnessApp
//
//  Created by Jane Strashok on 31.07.2024.
//

import Foundation

extension Int {
    func convertToDate() -> Date {
        Date(timeIntervalSince1970: TimeInterval(self))
    }
}
