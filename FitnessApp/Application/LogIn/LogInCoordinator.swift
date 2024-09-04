//
//  LogInCoordinator.swift
//  FitnessApp
//
//  Created by Jane Strashok on 14.07.2024.
//

import UIKit

final class LogInCoordinator: Coordinator {
    
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = LogInViewController.instantiate(from: Identifiers.Storyboard.logIn)
        let viewModel = LogInViewModel()
        viewModel.coordinator = self
        vc.viewModel = viewModel
        navigationController.pushViewController(vc, animated: true)
    }
    
    func navigateToTabBar(with user: UserModel) {
        let child = TabCoordinator(navigationController, user: user)
        
        child.start()
    }
    
    func navigateToSplash() {
        let child = SplashCoordinator(navigationController: navigationController)
        
        child.start()
    }
    
    func navigateToForgotPassword() {
        let child = ForgotPasswordCoodinator(navigationController: navigationController)
        
        child.start()
    }
}
