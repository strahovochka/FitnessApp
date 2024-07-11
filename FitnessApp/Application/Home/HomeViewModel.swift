//
//  HomeViewModel.swift
//  FitnessApp
//
//  Created by Jane Strashok on 30.06.2024.
//

import UIKit

final class HomeViewModel: BaseViewModel<HomeCoordinator> {
    
    private(set) var user: RegistrationModel
    
    init(user: RegistrationModel) {
        self.user = user
    }
    
    func getUserSex() -> String {
        if let sex = user.sex {
            if sex == "female" {
                return "Supergirl"
            } else {
                return "Superman"
            }
        }
        return ""
    }
}
