//
//  Style.swift
//  FitnessApp
//
//  Created by Jane Strashok on 22.07.2024.
//

import UIKit

//TODO: -Make style for different ui elements
class Style {
    static func customizeNavBar() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.titleTextAttributes = [
            .foregroundColor : UIColor.primaryWhite,
            .font: UIFont.mediumSaira?.withSize(18) ?? .systemFont(ofSize: 18)
        ]
        navigationBarAppearance.backgroundColor = .clear
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().compactAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
    }
}
