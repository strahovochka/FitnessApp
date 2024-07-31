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
    let user: UserModel?
    
    init(navigationController: UINavigationController, user: UserModel? = nil) {
        self.navigationController = navigationController
        self.user = user
    }
    
    func start() {
        let vc = ProgressViewController.instantiate(from: Identifiers.Storyboard.progress)
        let viewModel = ProgressViewModel(user: user)
        UserChangeManager.shared.add(observer: viewModel)
        viewModel.coordinator = self
        vc.viewModel = viewModel
        navigationController.pushViewController(vc, animated: true)
    }
}
