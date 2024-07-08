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
    private var sex: Sex
    
    init(navigationController: UINavigationController, sex: Sex) {
        self.navigationController = navigationController
        self.sex = sex
    }
    
    func start() {
        let vc = HomeViewController.instantiate(for: "Home")
        let viewModel = HomeViewModel(sex: sex)
        viewModel.coordinator = self
        vc.viewModel = viewModel
        navigationController.pushViewController(vc, animated: true)
    }
}
