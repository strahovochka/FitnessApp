//
//  Date+Extension.swift
//  FitnessApp
//
//  Created by Jane Strashok on 29.07.2024.
//

import Foundation

extension Date {
    func getSecondsSince1970() -> Int {
        Int(self.timeIntervalSince1970)
    }
    
    func formatDate(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
