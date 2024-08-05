//
//  PopUpCoordinator.swift
//  FitnessApp
//
//  Created by Jane Strashok on 18.07.2024.
//

import UIKit
struct PopUpButtonConfig {
    let title: String
    let type: PlainButton.ViewType
    let action: (() -> ())?
}

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
    let completition: (() -> ())?
    
    init(navigationController: UINavigationController, message: String, type: ViewType, completition: (() -> ())? = nil) {
        self.navigationController = navigationController
        self.message = message
        self.type = type
        self.completition = completition
    }
    
    func start() {
        let vc = PopUpViewConrtoller.instantiate(from: Identifiers.Storyboard.popUp)
        let viewModel = PopUpViewModel(title: message, type: type, completiton: completition)
        viewModel.coordinator = self
        vc.viewModel = viewModel
        navigationController.present(vc, animated: true)
    }
}
