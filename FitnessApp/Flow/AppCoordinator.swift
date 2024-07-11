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
        if let user = Auth.auth().currentUser {
            let db = FirebaseService.shared.firestore
            let document = db.collection("users").document(user.uid)
            print(user.uid)
            document.getDocument { [weak self] snapshop, error in
                guard let self = self else { return }
                if let data = snapshop?.data() {
                    if let sex = data["sex"] as? String {
                        if sex.isEmpty {
                            self.splashFlow()
                        } else {
                            self.mainFlow()
                        }
                    } else {
                        self.registerFlow()
                    }
                } else {
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
        childCoordinators.append(child)
        child.start()
    }
    
    func splashFlow() {
        let child = SplashCoordinator(navigationController: navigationController)
        childCoordinators.append(child)
        child.start()
    }
    
    func mainFlow() {
        let child = TabCoordinator(navigationController)
        childCoordinators.append(child)
        child.start()
    }
}
