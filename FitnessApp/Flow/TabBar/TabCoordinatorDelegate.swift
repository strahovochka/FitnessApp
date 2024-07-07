//
//  TabBarCoordinatorDelegate.swift
//  FitnessApp
//
//  Created by Jane Strashok on 07.07.2024.
//

import UIKit

enum TabBarItem: Int, CaseIterable {
    case home
    case progress
    case calculator
    case muscles
    
    var title: String {
        switch self {
        case .home:
            return "Home"
        case .progress:
            return "Progress"
        case .calculator:
            return "Calculator"
        case .muscles:
            return "Muscles"
        }
    }
    
    var image: UIImage? {
        switch self {
        case .home:
            return .homeTab
        case .progress:
            return .progressTab
        case .calculator:
            return .calculatorTab
        case .muscles:
            return .musclesTab
        }
    }
    
    var selectedImage: UIImage? {
        switch self {
        case .home:
            return .homeTabSelected
        case .progress:
            return .progressTabSelected
        case .calculator:
            return .calculatorTabSelected
        case .muscles:
            return .musclesTabSelected
        }
    }
    
    var coordinator: Coordinator {
        switch self {
        case .home:
            return HomeCoordinator(navigationController: UINavigationController())
        case .progress:
            return ProgressCoordinator(navigationController: UINavigationController())
        case .calculator:
            return CalculatorCoordinator(navigationController: UINavigationController())
        case .muscles:
            return MusclesCoordinator(navigationController: UINavigationController())
        }
    }
}

protocol TabCoordinatorDelegate: Coordinator {
    var tabBarController: UITabBarController { get set }
    func selectTab(_ tab: TabBarItem)
    func setSelectedIndex(_ index: Int)
    func currentTab() -> TabBarItem?
}
