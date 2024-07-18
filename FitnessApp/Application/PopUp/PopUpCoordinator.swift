//
//  PopUpCoordinator.swift
//  FitnessApp
//
//  Created by Jane Strashok on 18.07.2024.
//

import UIKit

final class PopUpCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    let message: String
    let defaultButtonTitile: String
    let defaultAction: () -> ()
    var secondaryAction: (() -> ())?
    var secondaryButtonTitile: String?
    
    init(navigationController: UINavigationController, message: String, defaultButtonTitile: String, secondaryButtonTitle: String? = nil, defaultAction: @escaping () -> (), secondaryAction: (() -> ())? = nil) {
        self.navigationController = navigationController
        self.message = message
        self.defaultButtonTitile = defaultButtonTitile
        self.defaultAction = defaultAction
        self.secondaryButtonTitile = secondaryButtonTitle
        self.secondaryAction = secondaryAction
    }
    
    func start() {
        let vc = PopUpViewConrtoller.instantiate(from: Identifiers.Storyboard.popUp)
        let viewModel = PopUpViewModel(title: message, defaultButtonTitle: defaultButtonTitile, defaultAction: defaultAction)
        if let secondaryButtonTitile = secondaryButtonTitile, let secondaryAction = secondaryAction {
            viewModel.addAction(title: secondaryButtonTitile, action: secondaryAction)
        }
        viewModel.coordinator = self
        vc.viewModel = viewModel
        navigationController.present(vc, animated: true)
    }
    
    func navigateBack() {
        navigationController.popViewController(animated: true)
    }
}
