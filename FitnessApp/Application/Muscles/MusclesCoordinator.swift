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
    let user: UserModel?
    
    init(navigationController: UINavigationController, user: UserModel? = nil) {
        self.navigationController = navigationController
        self.user = user
    }
    
    func start() {
        let vc = MusclesViewController.instantiate(from: Identifiers.Storyboard.muscles)
        let viewModel = MusclesViewModel(user: user)
        viewModel.coordinator = self
        vc.viewModel = viewModel
        navigationController.pushViewController(vc, animated: true)
    }
}
