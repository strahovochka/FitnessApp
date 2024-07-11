//
//  SplashViewModel.swift
//  FitnessApp
//
//  Created by Jane Strashok on 08.07.2024.
//

import Foundation

enum Sex: String {
    case male = "male"
    case female = "female"
}

final class SplashViewModel: BaseViewModel<SplashCoordinator> {
    
    func heroChosen(_ sex: Sex) {
        FirebaseService.shared.setUserSex(sex) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success:
                self.coordinator?.navigateToTabBar(with: sex)
            case .failure(let error):
                self.coordinator?.showAlert(title: error, actions: ["Ok": .default])
            case .unknown:
                break
            }
        }
        
    }
}
