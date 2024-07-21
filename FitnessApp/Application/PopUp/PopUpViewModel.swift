//
//  PopUpViewModel.swift
//  FitnessApp
//
//  Created by Jane Strashok on 18.07.2024.
//

import Foundation

final class PopUpViewModel: BaseViewModel<PopUpCoordinator> {
    
    let title: String
    let type: PopUpCoordinator.ViewType
    
    init(title: String, type: PopUpCoordinator.ViewType) {
        self.title = title
        self.type = type
    }
}
