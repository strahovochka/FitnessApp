//
//  ProfileCoordinator.swift
//  FitnessApp
//
//  Created by Jane Strashok on 20.07.2024.
//

import UIKit

final class ProfileCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    let user: UserModel
    var delegate: UserDataChangable?
    
    init(navigationController: UINavigationController, user: UserModel, delegate: UserDataChangable) {
        self.navigationController = navigationController
        self.user = user
        self.delegate = delegate
    }
    
    func start() {
        let vc = ProfileViewController.instantiate(from: Identifiers.Storyboard.profile)
        vc.hidesBottomBarWhenPushed = true
        vc.delegate = delegate
        let viewModel = ProfileViewModel(user: user)
        viewModel.coordinator = self
        vc.viewModel = viewModel
        navigationController.pushViewController(vc, animated: true)
    }
}
