//
//  ProgressCoordinator.swift
//  FitnessApp
//
//  Created by Jane Strashok on 07.07.2024.
//

import UIKit

final class ProgressCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = ProgressViewController.instantiate(for: "Progress")
        navigationController.pushViewController(vc, animated: true)
    }
}
