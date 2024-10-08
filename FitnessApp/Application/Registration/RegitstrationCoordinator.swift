//
//  RegitstrationCoordinator.swift
//  FitnessApp
//
//  Created by Jane Strashok on 09.07.2024.
//

import UIKit

final class RegistrationCoordinator: Coordinator {
    
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = RegistrationViewController.instantiate(from: Identifiers.Storyboard.registration)
        let viewModel = RegistrationViewModel()
        viewModel.coordinator = self
        vc.viewModel = viewModel
        navigationController.pushViewController(vc, animated: true)
    }
    
    func navigateToSplashScreen() {
        let child = SplashCoordinator(navigationController: navigationController)
        
        child.start()
    }
    
    func navigateToLogIn() {
        let child = LogInCoordinator(navigationController: navigationController)
        
        child.start()
    }
}
