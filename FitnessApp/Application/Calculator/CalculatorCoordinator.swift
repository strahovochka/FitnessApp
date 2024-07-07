//
//  CalculatorCoordinator.swift
//  FitnessApp
//
//  Created by Jane Strashok on 07.07.2024.
//

import UIKit

final class CalculatorCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = CalculatorViewController.instantiate(for: "Calculator")
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}
