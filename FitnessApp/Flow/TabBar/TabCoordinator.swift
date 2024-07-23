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
    let user: UserModel?
    
    init(_ navigationController: UINavigationController, user: UserModel? = nil) {
        self.navigationController = navigationController
        self.user = user
    }
    
    func start() {
        let controller = TabViewController.instantiate(from: Identifiers.Storyboard.tabBar)
        let viewModel = TabViewModel(user: user)
        viewModel.coordinator = self
        controller.viewModel = viewModel
        self.navigationController.pushViewController(controller, animated: true)
    }
}
