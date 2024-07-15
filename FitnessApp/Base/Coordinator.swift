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
    func showAlert(title: String, message: String? = nil, actions: [String: UIAlertAction.Style] = ["Ok": .default]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for (title, style) in actions {
            let alertAction = UIAlertAction(title: title, style: style)
            alert.addAction(alertAction)
        }
        self.navigationController.present(alert, animated: true)
    }
}
