//
//  SplashViewModel.swift
//  FitnessApp
//
//  Created by Jane Strashok on 08.07.2024.
//

import Foundation

enum Sex: String {
    case male = "Superman"
    case female = "Supergirl"
}

final class SplashViewModel: BaseViewModel<SplashCoordinator> {
    
    func heroChosen(_ sex: Sex) {
        coordinator?.navigateToTabBar(with: sex)
    }
}
