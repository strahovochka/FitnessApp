//
//  Coordinator.swift
//  FitnessApp
//
//  Created by Jane Strashok on 01.07.2024.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get }
    
    func start()
}

extension Coordinator {
    func showPopUp(title: String, buttonTitle: String, secondaryTitle: String? = nil, buttonAction: @escaping () -> (), secondaryAction: (() -> ())? = nil) {
        let child = PopUpCoordinator(navigationController: navigationController, message: title, defaultButtonTitile: buttonTitle, secondaryButtonTitle: secondaryTitle, defaultAction: buttonAction, secondaryAction: secondaryAction)
        childCoordinators.append(child)
        child.start()
    }
}
