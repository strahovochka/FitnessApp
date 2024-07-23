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
    
    var heroName: String {
        switch self {
        case .male:
            return "Superman"
        case .female:
            return "Supergirl"
        }
    }
}

final class SplashViewModel: BaseViewModel<SplashCoordinator> {
    
    let title = "Superhero".uppercased()
    let subtitle = "Choose your hero"
    
    func heroChosen(_ sex: Sex, completition: @escaping (Bool) -> ()) {
        FirebaseService.shared.setUserSex(sex) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success:
                self.coordinator?.navigateToTabBar()
                completition(true)
            case .failure(let error):
                self.coordinator?.showPopUp(title: error, type: .oneButton((title: "Ok", type: .filled, action: nil)))
                completition(false)
            case .unknown:
                self.coordinator?.showPopUp(title: "An unknow error occured", type: .oneButton((title: "Ok", type: .filled, action: nil)))
                completition(false)
            }
        }
        
    }
}
