//
//  Style.swift
//  FitnessApp
//
//  Created by Jane Strashok on 22.07.2024.
//

import UIKit

//TODO: -Make style for different ui elements
struct Style {
    static func customizeNavBar() {
        UINavigationBar.appearance().tintColor = .primaryYellow
        let buttonAppearance = UIBarButtonItemAppearance(style: .plain)
        buttonAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor.primaryYellow,
            .font: UIFont.regularSaira?.withSize(18) ?? .systemFont(ofSize: 18)
        ]
    }
}
