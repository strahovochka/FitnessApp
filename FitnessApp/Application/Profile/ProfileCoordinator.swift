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
    
    init(navigationController: UINavigationController, user: UserModel) {
        self.navigationController = navigationController
        self.user = user
    }
    
    func start() {
        let vc = ProfileViewController.instantiate(from: Identifiers.Storyboard.profile)
        vc.hidesBottomBarWhenPushed = true
        let viewModel = ProfileViewModel(user: user)
        viewModel.coordinator = self
        vc.viewModel = viewModel
        navigationController.pushViewController(vc, animated: true)
    }
    
    func navigateToOptions(with selectedOptions: [OptionDataName], delegate: OptionsPopUpDelegate) {
        let child = OptionsPopUpCoordinator(navigationController: navigationController, selection: selectedOptions, delegate: delegate)
        childCoordinators.append(child)
        child.start()
    }
}
