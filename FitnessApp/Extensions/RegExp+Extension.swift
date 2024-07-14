//
//  RegExp+Extension.swift
//  FitnessApp
//
//  Created by Jane Strashok on 09.07.2024.
//

import Foundation

extension NSRegularExpression {
    func matches(_ string: String) -> Bool {
        let range = NSRange(location: 0, length: string.utf16.count)
        return firstMatch(in: string, options: [], range: range) != nil
    }
}
