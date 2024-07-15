//
//  TabCoordinator.swift
//  FitnessApp
//
//  Created by Jane Strashok on 07.07.2024.
//

import UIKit

class TabCoordinator: NSObject, Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var user: RegistrationModel?
    
    init(_ navigationController: UINavigationController, user: RegistrationModel? = nil) {
        self.navigationController = navigationController
        self.user = user
    }
    
    func start() {
        let controller = TabViewController.instantiate(from: Identifiers.Storyboard.tabBar)
        let viewModel = TabViewModel()
        viewModel.coordinator = self
        controller.viewModel = viewModel
        if let user = user {
            viewModel.setUser(user)
            self.navigationController.pushViewController(controller, animated: true)
        } else {
            viewModel.getUser { [weak self] user in
                guard let self = self else { return }
                self.user = user
                self.navigationController.pushViewController(controller, animated: true)
            }
        }
    }
}
