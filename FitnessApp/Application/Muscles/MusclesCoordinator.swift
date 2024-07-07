//
//  MusclesCoordinator.swift
//  FitnessApp
//
//  Created by Jane Strashok on 07.07.2024.
//

import UIKit

final class MusclesCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = MusclesViewController.instantiate(for: "Muscles")
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}
