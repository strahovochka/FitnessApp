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
    
    func getUserSex() -> (title: String, sex: Sex) {
        if let sex = user.sex {
            if sex == "female" {
                return ("Supergirl", .female)
            } else {
                return ("Superman", .male)
            }
        }
        return ("", .male)
    }
}
