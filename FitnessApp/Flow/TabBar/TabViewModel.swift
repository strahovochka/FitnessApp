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
    
    func getCoodrinator(with user: RegistrationModel) -> Coordinator {
        switch self {
        case .home:
            return HomeCoordinator(navigationController: UINavigationController(), user: user)
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
    
    private(set) var user: RegistrationModel?
    
    func getControllers() -> [UIViewController] {
        var controllers = [UIViewController]()
        let tabs = TabBarItem.allCases
        tabs.forEach { tab in
            if let user = user {
                let coordinator = tab.getCoodrinator(with: user)
                coordinator.navigationController.setNavigationBarHidden(true, animated: false)
                coordinator.navigationController.tabBarItem = UITabBarItem.init(title: tab.title, image: tab.image, tag: tab.rawValue)
                coordinator.navigationController.tabBarItem.selectedImage = tab.selectedImage
                coordinator.start()
                controllers.append(coordinator.navigationController)
            }
        }
        return controllers
    }
    
    func getUser(completition: @escaping (RegistrationModel) -> ()) {
        FirebaseService.shared.getUser { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let userModel):
                self.user = userModel
                completition(userModel)
            case .failure(let error):
                self.coordinator?.showAlert(title: error)
            case .unknown:
                self.coordinator?.showAlert(title: "An unknown error occured")
            }
        }
    }
    
    func setUser(_ user: RegistrationModel) {
        self.user = user
    }
}
