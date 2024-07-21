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
    func showPopUp(title: String, type: PopUpCoordinator.ViewType) {
        let child = PopUpCoordinator(navigationController: navigationController, message: title, type: type)
        childCoordinators.append(child)
        child.start()
    }
}
