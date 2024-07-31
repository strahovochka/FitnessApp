//
//  ChartCoordinator.swift
//  FitnessApp
//
//  Created by Jane Strashok on 31.07.2024.
//

import UIKit

final class ChartCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = ChartViewController.instantiate(from: Identifiers.Storyboard.chart)
        let viewModel = ChartViewModel()
        viewModel.coordinator = self
        vc.viewModel = viewModel
        navigationController.pushViewController(vc, animated: true)
    }
    
    
}
