//
//  PopUpCoordinator.swift
//  FitnessApp
//
//  Created by Jane Strashok on 18.07.2024.
//

import UIKit
typealias PopUpButtonConfig = (title: String, type: PlainButton.ViewType, action: (()->())?)

final class PopUpCoordinator: Coordinator {

    enum ViewType {
        case buttonless(UIImage?)
        case oneButton(PopUpButtonConfig)
        case twoButtons((leftButton: PopUpButtonConfig, rightButton: PopUpButtonConfig))
    }
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    let message: String
    let type: ViewType
    
    init(navigationController: UINavigationController, message: String, type: ViewType) {
        self.navigationController = navigationController
        self.message = message
        self.type = type
    }
    
    func start() {
        let vc = PopUpViewConrtoller.instantiate(from: Identifiers.Storyboard.popUp)
        let viewModel = PopUpViewModel(title: message, type: type)
        viewModel.coordinator = self
        vc.viewModel = viewModel
        navigationController.present(vc, animated: true)
    }
    
    func navigateBack() {
        navigationController.popViewController(animated: true)
    }
}
