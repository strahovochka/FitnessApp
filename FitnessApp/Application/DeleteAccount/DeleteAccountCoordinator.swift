//
//  DeleteAccountCoordinator.swift
//  FitnessApp
//
//  Created by Jane Strashok on 02.08.2024.
//

import UIKit

final class DeleteAccountCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    let user: UserModel
    
    init(navigationController: UINavigationController, user: UserModel) {
        self.navigationController = navigationController
        self.user = user
    }
    func start() {
        let vc = DeleteAccountViewController.instantiate(from: Identifiers.Storyboard.deleteAccount)
        let viewModel = DeleteAccountViewModel(user: user)
        viewModel.coordinator = self
        vc.viewModel = viewModel
        navigationController.pushViewController(vc, animated: true)
    }
}
