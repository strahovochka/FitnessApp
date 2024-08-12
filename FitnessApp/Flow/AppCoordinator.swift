//
//  AppCoordinator.swift
//  FitnessApp
//
//  Created by Jane Strashok on 30.06.2024.
//

import UIKit
import FirebaseAuth

class AppCoordinator: Coordinator {

    var childCoordinators: [Coordinator] = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        if let _ = Auth.auth().currentUser {
            FirebaseService.shared.getUser { [weak self] response in
                guard let self = self else { return }
                switch response {
                case .success(let user):
                    if user.sex.isEmpty {
                        self.splashFlow()
                    } else {
                        self.mainFlow(with: user)
                    }
                default:
                    self.registerFlow()
                }
            }
        } else {
            registerFlow()
        }
    }
    
    func childDidFinish(_ child: Coordinator) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
    
    func registerFlow() {
        let child = RegistrationCoordinator(navigationController: navigationController)
        
        child.start()
    }
    
    func splashFlow() {
        let child = SplashCoordinator(navigationController: navigationController)
        
        child.start()
    }
    
    func mainFlow(with user: UserModel) {
        let child = TabCoordinator(navigationController, user: user)
        
        child.start()
    }
}
