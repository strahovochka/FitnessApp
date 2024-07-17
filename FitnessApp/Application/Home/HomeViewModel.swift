//
//  HomeViewModel.swift
//  FitnessApp
//
//  Created by Jane Strashok on 30.06.2024.
//

import UIKit

final class HomeViewModel: BaseViewModel<HomeCoordinator> {
    
    private(set) var user: RegistrationModel?
    let heroPlaceholderName = "Hero"
    let namePlaceholder = "Name"
    
    init(user: RegistrationModel? = nil) {
        self.user = user
    }
    
    func getUserSex() -> (title: String, sex: Sex) {
        if let user = user, let sex = user.sex {
            if sex == "female" {
                return ("Supergirl", .female)
            } else {
                return ("Superman", .male)
            }
        }
        return ("", .male)
    }
    
    func getUser(completition: @escaping (RegistrationModel) -> ()) {
        if let user = user {
            completition(user)
            return
        }
        FirebaseService.shared.getUser { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let userModel):
                self.user = userModel
                completition(userModel)
            case .failure(let error):
                self.coordinator?.showPopUp(title: error, actions: ["Ok": .ok])
            case .unknown:
                self.coordinator?.showPopUp(title: "An unknown error occured", actions: ["Ok": .ok])
            }
        }
    }
}
