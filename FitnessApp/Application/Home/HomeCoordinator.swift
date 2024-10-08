//
//  HomeCoordinator.swift
//  FitnessApp
//
//  Created by Jane Strashok on 30.06.2024.
//

import UIKit

final class HomeCoordinator: Coordinator {
    
    
    
    var navigationController: UINavigationController
    private var user: UserModel?
    
    init(navigationController: UINavigationController, user: UserModel? = nil) {
        self.navigationController = navigationController
        self.user = user
    }
    
    func start() {
        let vc = HomeViewController.instantiate(from: Identifiers.Storyboard.home)
        let viewModel = HomeViewModel(user: user)
        viewModel.coordinator = self
        vc.viewModel = viewModel
        navigationController.pushViewController(vc, animated: true)
    }
    
    func navigateToProfile(with user: UserModel) {
        let child = ProfileCoordinator(navigationController: navigationController, user: user)
        
        child.start()
    }
}
