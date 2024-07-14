//
//  SplashCoordinator.swift
//  FitnessApp
//
//  Created by Jane Strashok on 07.07.2024.
//

import UIKit

final class SplashCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = SplashViewController.instantiate(from: Identifiers.Storyboard.splashScreen)
        let viewModel = SplashViewModel()
        viewModel.coordinator = self
        vc.viewModel = viewModel
        navigationController.pushViewController(vc, animated: true)
    }
    
    func navigateToTabBar(with hero: Sex) {
        let tabBarCoordinator = TabCoordinator(navigationController)
        self.navigationController.navigationBar.isHidden = true
        tabBarCoordinator.start()
        childCoordinators.append(tabBarCoordinator)
    }
}
