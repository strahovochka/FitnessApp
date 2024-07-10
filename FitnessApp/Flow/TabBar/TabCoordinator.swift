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
    
    private var sex: Sex
    
    init(_ navigationController: UINavigationController, sex: Sex) {
        self.navigationController = navigationController
        self.sex = sex
    }
    
    func start() {
        let controller = TabViewController.instantiate(from: Identifiers.Storyboard.tabBar)
        let viewModel = TabViewModel(sex: sex)
        viewModel.coordinator = self
        controller.viewModel = viewModel
        navigationController.pushViewController(controller, animated: true)
    }
}
