//
//  TabViewModel.swift
//  FitnessApp
//
//  Created by Jane Strashok on 09.07.2024.
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
    
    func getCoodrinator(with sex: Sex = .female) -> Coordinator {
        switch self {
        case .home:
            return HomeCoordinator(navigationController: UINavigationController(), sex: sex)
        case .progress:
            return ProgressCoordinator(navigationController: UINavigationController())
        case .calculator:
            return CalculatorCoordinator(navigationController: UINavigationController())
        case .muscles:
            return MusclesCoordinator(navigationController: UINavigationController())
        }
    }
}

final class TabViewModel: BaseViewModel<TabCoordinator> {
    
    private(set) var sex: Sex
    
    init(sex: Sex) {
        self.sex = sex
    }
    
    func getControllers() -> [UIViewController] {
        var controllers = [UIViewController]()
        let tabs = TabBarItem.allCases
        tabs.forEach { tab in
            let coordinator = tab.getCoodrinator(with: sex)
            coordinator.navigationController.setNavigationBarHidden(true, animated: false)
            coordinator.navigationController.tabBarItem = UITabBarItem.init(title: tab.title, image: tab.image, tag: tab.rawValue)
            coordinator.navigationController.tabBarItem.selectedImage = tab.selectedImage
            coordinator.start()
            controllers.append(coordinator.navigationController)
        }
        return controllers
    }
}
