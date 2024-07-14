//
//  UITableViewCell+Extension.swift
//  FitnessApp
//
//  Created by Jane Strashok on 09.07.2024.
//

import UIKit

extension UITableViewCell {
    static func cellIdentifier() -> String {
        return String(describing: self)
    }
}
