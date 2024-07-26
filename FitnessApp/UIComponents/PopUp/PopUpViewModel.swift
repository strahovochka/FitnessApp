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
    let completition: (() -> ())?
    
    init(title: String, type: PopUpCoordinator.ViewType, completiton: (() -> ())? = nil) {
        self.title = title
        self.type = type
        self.completition = completiton
    }
}
