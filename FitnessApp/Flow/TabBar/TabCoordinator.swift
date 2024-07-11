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
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let controller = TabViewController.instantiate(from: Identifiers.Storyboard.tabBar)
        let viewModel = TabViewModel()
        viewModel.getUser { [weak self] user in
            guard let self = self else { return }
            viewModel.coordinator = self
            controller.viewModel = viewModel
            self.navigationController.pushViewController(controller, animated: true)
        }
        
    }
}
