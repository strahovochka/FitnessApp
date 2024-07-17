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
    func showPopUp(title: String, actions: [String: CustomPopUp.ButtonType], handler: ((CustomPopUp.ButtonType) -> ())? = nil) {
        let popUpViewController = CustomPopUp()
        popUpViewController.title = title
        for (title, type) in actions {
            if let handler = handler {
                popUpViewController.addAction(title: title, type: type) { type in
                    handler(type)
                }
            } else {
                popUpViewController.addAction(title: title, type: type)
            }
        }
        navigationController.topViewController?.present(popUpViewController, animated: true)
    }
}
