//
//  HomeCoordinator.swift
//  FitnessApp
//
//  Created by Jane Strashok on 30.06.2024.
//

import UIKit

final class HomeCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = HomeViewController.instantiate(for: "Home")
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    
}
