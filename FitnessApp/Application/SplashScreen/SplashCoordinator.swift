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
        let vc = SplashViewController.instantiate(for: "Splash")
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func navigateToTabBar() {
        
    }
}
